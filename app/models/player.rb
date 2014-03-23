#encoding: utf-8

class Player < ActiveRecord::Base
  require 'csv'

  Armies = ['Grey Knights', 'Eldars', 'Space Marines', 'Chaos Space Marines', 'Space Wolves',
             'Imperial Guard', 'Chaos Daemons', 'Blood Angels', 'Dark Angels',
             'Orks', 'Dark Eldars', 'Black Templars', 'Sister of Battle',
             'Tyranids', 'Necrons', 'Tau']

  has_many :tournament_registrations, :dependent => :nullify
  has_many :played_tournaments, :dependent => :destroy
  has_one  :rank_place, :dependent => :destroy
  has_many :team_registration_players, :dependent => :nullify
  has_many :team_regisrations, :through => :team_registration_players, :dependent => :nullify
  has_many :played_tournaments, :dependent => :destroy
  has_one  :rank_place, :dependent => :destroy
  has_many :team_registration_players, :dependent => :nullify
  has_many :team_regisrations, :through => :team_registration_players, :dependent => :nullify
  has_many :player1_pairings, :class_name => 'TournamentPairing', :foreign_key => 'player1_id'
  has_many :player2_pairings, :class_name => 'TournamentPairing', :foreign_key => 'player2_id'
  has_many :pairings, :class_name => 'TournamentPairing', :finder_sql => Proc.new {
    %Q{
      SELECT DISTINCT *
      FROM tournament_pairings AS tp
      WHERE tp.player1_id = #{id} OR tp.player2_id = #{id}
    }
  }
  
  #def pairings
  #   player1_pairings + player2_pairings
  #end


  #validates_presence_of :nick
  validates_uniqueness_of :league_id, :allow_blank => true
  validates_format_of :league_id, :with => /^[A-Za-z]{2}\d{3}$/, :allow_blank => true
  def full_name
    if first_name && last_name
      "#{first_name} #{last_name}"
    else
      nick
    end
  end
  
  def full_name_with_id
    "#{league_id} - #{full_name}"
  end

  def name
    "#{first_name} '#{nick}' #{last_name}"
  end

  def points_for_tournament(id)
    player1_pairings.where(:tournament_id => id).sum(:player1_match_points) +
    player2_pairings.where(:tournament_id => id).sum(:player2_match_points) 
  end
  
  def game_points_for_tournament(id)
    player1_pairings.where(:tournament_id => id).sum(:player1_game_points) +
    player2_pairings.where(:tournament_id => id).sum(:player2_game_points) 
  end

  def played_with?(registration = nil)
    return false unless registration.present?
    tournament = registration.tournament_id
    player1_pairings.where(:tournament_id => tournament, :player2_id => registration.player_id).any? or
    player2_pairings.where(:tournament_id => tournament, :player1_id => registration.player_id).any?
  end

  def self.import(file)
    CSV.parse(file) do |row|
      user = Player.find_or_initialize_by_league_id(row[0])
      user.update_attributes(  :first_name => row[1], 
                               :last_name => row[2],
                               :nick => row[3],
                               :city => row[4])
      user.save
    end
  end

end
