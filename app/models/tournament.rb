#encoding: utf-8

class Tournament < ActiveRecord::Base
  extend FriendlyId
  include AASM
  include TournamentsHelper

  mount_uploader :results, ResultsUploader

  TournamentRanks = ['Lokal', 'Czelendżer', 'Master']
  RankPoints = {
                'Lokal' => 3,
                'Czelendżer' => 5,
                'Master' => 5
               }

  BASE_RANK_POINTS = {
    'Lokal' => 20, 'Czelendżer' => 35, 'Master' => 50
  }


  attr_accessor :results_required
  validates_presence_of :name, :rank, :start_date, :city, :number_of_rounds #add date
  validates_numericality_of :number_of_rounds, :greater_than => 0
  validates_uniqueness_of :name
  validates_presence_of :team_members_count, :if => Proc.new { |t| t.for_teams? }
  validates_presence_of :results, :if => Proc.new { |t| t.results_required.present? }

  belongs_to :user
  has_many :pairings, :class_name => "TournamentPairing", :dependent => :destroy
  has_many :pages, :dependent => :destroy
  has_many :tournament_registrations, :dependent => :destroy
  has_many :team_registrations, :dependent => :destroy
  has_many :team_pairings, :class_name => "TournamentTeamPairing", :dependent => :destroy
  has_many :posts, :dependent => :destroy
  has_many :played_tournaments, :dependent => :destroy
  friendly_id :name, use: :slugged
  #has_many :hostel_bookings, :dependent => :destroy

  after_create :import_results

  aasm :column => 'state' do

    state :new, :initial => true
    state :ongoing
    state :finished
    state :counted
    state :imported

    event :start do
      transitions from: :new, to: :ongoing
    end

    event :finish do
      transitions from: :ongoing, to: :finished
    end

    event :count do
      transitions from: [:finished, :imported], to: :counted
    end

    event :uncount do
      transitions from: :counted, to: :finished
    end
  end

  def import_results
    return true unless results.present?

    CSV.parse(results.read, headers: true, col_sep: ';') do |row|
      puts row
      break if row[0].match(/Runda/)
      create_registration(row)

    end

    self.update_column(:state, 'imported')
  end

  def create_registration(row)
    reg = self.tournament_registrations.create(
          player_id: Player.find_or_create_by_league_id(row[1]).id,
          army: row[4],
          current_points: row[6],
          current_victory_points: row[6],
          played_games: self.number_of_rounds,
          extra_points: 0,
          penalty_points: 0)

    # self.played_tournaments.create(
    #       player_id: reg.player_id,
    #       place: row[0],
    #       points: row[6],
    #       registration_id: reg.id)

  end

  def update_round
    increment!(:current_round)
  end

  TournamentRanks.each do |meth|
    define_method("is_#{meth.downcase}?".to_sym) do
      self.rank == meth
    end
  end

  def round_completed?
    if for_teams?
      team_pairings.where(:round => current_round).select{|p| p.invalid?(:update)}.empty?
    else
      pairings.where(:round => current_round).select{|p| p.invalid?(:update)}.empty?
    end
  end

  def get_pairings
    if for_teams?
      team_pairings
    else
      pairings
    end
  end

  def generate_pairings
    return false if last_round?
    transaction do
      check_round
      registrations = prepare_registrations
      create_pairings(registrations)
      return true
    end
  end

  def prepare_registrations
    registrations = for_teams? ? team_registrations : tournament_registrations
    if current_round == 1
      registrations = registrations.shuffle
    else
      registrations = sort_players(registrations)
    end
    registrations = remove_pausing_pairing(registrations) if registrations.size.odd?
    registrations

  end

  def check_round
    if current_round == 0
      start!
      update_round
    else
      update_round
    end
  end

  def create_pairings(registrations)
    table = 1
    sorted_registrations = prepare_list(registrations)
    sorted_registrations.each_slice(2) do |p1, p2|
      if for_teams?
        team_pairings.create(:team1_id => p1.id, :team2_id => p2.id, :round => current_round, :table => table)
      else
        pairings.create(:player1_id => p1.player_id, :player2_id => p2.player_id, :round => current_round, :table => table)
      end
      table += 1
    end
  end

  def prepare_list(registrations)
    sorted_players = []
    while registrations.any? do
      p1 = registrations.shift
      sorted_players << p1
      index = 0
      while player_or_team(p1).played_with?(registrations[index]) do
        index += 1
      end
      sorted_players << registrations.slice!(index)
    end
    sorted_players.compact
  end

  def player_or_team(registration)
    if registration.class.name == 'TournamentRegistration'
      registration.player
    else
      registration
    end
  end


  def sort_players(registrations)
    registrations.sort_by { |registration| [registration.current_points, registration.current_victory_points] }.reverse
  end

  def last_round?
    current_round == number_of_rounds
  end

  def can_finish?
    last_round? && round_completed? && !finished?
  end

  def pausing_pairing
    pairings.where(:pausing => true)
  end

  def rank_points
    Tournament::BASE_RANK_POINTS[rank]
  end

  def self.past
    where('start_date < ?', Time.now)
  end

  def self.upcomming
    where('start_date > ?', Time.now)
  end

  def points_for_registration(reg)
    if for_teams?
      registrations = team_registrations.sort{|a,b| b.final_points <=> a.final_points}
    else
      registrations = tournament_registrations.sort{|a,b| b.final_points <=> a.final_points}
    end
    base = (registrations.size < 15 && is_lokal?) ? 5 + registrations.size : rank_points
    place = registrations.index(reg) + 1
    rank = Tournament::RankPoints[self.rank]
    extra_points = place <= rank ? rank + 1 - place : 0

    points = (base.to_f * (registrations.size + 1 - place) / registrations.size).ceil + extra_points
  end

  def add_to_rank
    regs = sort_players(tournament_registrations)
    transaction do
      regs.each_with_index do |reg, i|
        PlayedTournament.create(player_id: reg.player_id,
                                tournament_id: self.id,
                                place: i+1,
                                points: points_for_registration(reg),
                                registration_id: reg.id)
      end
      RankPlace.update_places
      self.count!
    end
  end

  def imported_results
    Tournament.import(results.read)
  end

  def self.import(file)
    rows = []
    CSV.parse(file, headers: true, col_sep: ';') do |row|
      puts row
      break if row[0].match(/Runda/)
      rows << [row[0], row[1], row[2], row[3], row[4], row[5], row[6]]
    end
    rows
  end

  private

  def remove_pausing_pairing(players)
    pausing_player = players.pop
    create_pausing_pairing(pausing_player)
    players
  end

  def create_pausing_pairing(player)
    if player.class.name == 'TournamentRegistration'
      pairings.create(:player1_id => player.player.id, :pausing => true, :round => current_round,
                      :player1_game_points => pause_victory_points, :player2_game_points => 0,
                      :player1_match_points => pause_game_points, :player2_match_points => 0)
    else
      team_pairings.create(:team1_id => player.id, :pausing => true, :round => current_round, :team1_game_points => 5, :team2_game_points => 0, :team1_match_points => 15, :team2_match_points => 0)
    end
  end
end
