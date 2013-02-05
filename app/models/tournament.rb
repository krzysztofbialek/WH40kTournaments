#encoding: utf-8

class Tournament < ActiveRecord::Base
  extend FriendlyId
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

  def update_round
    increment!(:current_round)
  end


  def generate_pairings
    return false if last_round?
    update_round 
    players = tournament_registrations
    players = remove_pausing_pairing(players) if players.size.odd?
    create_pairings(players)
    true
  end

  def create_pairings(players)
    table = 1
    players.each_slice(2) do |p1, p2|
      pairings.create(:player1_id => p1.player_id, :player2_id => p2.player_id, :round => current_round, :table => table)
      table += 1
    end
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
    pairings.create(:player1_id => pausing_player.id, :pausing => true, :round => current_round)
    players
  end
end
