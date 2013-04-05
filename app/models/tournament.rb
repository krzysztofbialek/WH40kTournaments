#encoding: utf-8

class Tournament < ActiveRecord::Base
  extend FriendlyId
  include AASM
  TournamentRanks = ['Lokal', 'Czelendżer', 'Master']

  validates_presence_of :name, :start_date, :rank, :city, :number_of_rounds
  validates_numericality_of :number_of_rounds
  validates_uniqueness_of :name
  
  belongs_to :user
  has_many :pairings, :class_name => "TournamentPairing", :dependent => :destroy
  has_many :pages, :dependent => :destroy
  has_many :tournament_registrations, :dependent => :destroy
  has_many :posts, :dependent => :destroy
  friendly_id :name, use: :slugged
  #has_many :hostel_bookings, :dependent => :destroy

  aasm :column => 'state' do
  
    state :new, :initial => true
    state :ongoing
    state :finished
 
    event :start do
      transitions from: :new, to: :ongoing
    end
 
    event :finish do
      transitions from: :ongoing, to: :finished
    end
  end

  def update_round
    increment!(:current_round)
  end

  def round_completed?
    pairings.where(:round => current_round).select(&:invalid?).empty?
  end

  def generate_pairings
    return false if last_round?
    update_round 
    registrations = tournament_registrations
    if current_round == 1
      registrations = registrations.shuffle
    else
      registrations = sort_players(registrations)
    end
    registrations = remove_pausing_pairing(registrations) if registrations.size.odd?
    create_pairings(registrations)
    true
  end

  def create_pairings(registrations)
    table = 1
    sorted_registrations = prepare_list(registrations)
    sorted_registrations.each_slice(2) do |p1, p2|
      pairings.create(:player1_id => p1.player_id, :player2_id => p2.player_id, :round => current_round, :table => table)
      table += 1
    end
  end

  def prepare_list(registrations)
    sorted_players = []
    while registrations.any? do
      p1 = registrations.shift
      sorted_players << p1
      index = 0
      while p1.player.played_with?(registrations[index]) do
        index += 1
      end
      sorted_players << registrations.slice!(index)
    end
    sorted_players.compact
  end

  def sort_players(registrations)
    registrations.sort_by { |registration| registration.player.points_for_tournament(self) }.reverse 
  end

  def last_round?
    current_round == number_of_rounds
  end
  
  def pausing_pairing
    pairings.where(:pausing => true)
  end

  private

  def remove_pausing_pairing(players)
    pausing_player = players.pop.player
    pairings.create(:player1_id => pausing_player.id, :pausing => true, :round => current_round, :player1_game_points => 13, :player2_game_points => 0)
    players
  end
end
