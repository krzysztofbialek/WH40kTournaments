#encoding: utf-8
class TeamRegistration < ActiveRecord::Base
  attr_accessible :team_registration_players_attributes, :current_points, :extra_points, :current_victory_points, :deleted_at, :name, :city, :paid_at, :payment_send, :penalty_points, :played_games, :roster_send, :roster_valid, :tournament_id

  belongs_to :tournament  
  has_many :team_registration_players
  has_many :players, through: :team_registration_players
  has_many :team1_pairings, :class_name => 'TournamentTeamPairing', :foreign_key => 'team1_id'
  has_many :team2_pairings, :class_name => 'TournamentTeamPairing', :foreign_key => 'team2_id'

  accepts_nested_attributes_for :team_registration_players
  
  def played_with?(registration = nil)
    return false unless registration.present?
    tournament = registration.tournament_id
    team1_pairings.where(:tournament_id => tournament, :team2_id => registration.id).any? or
    team2_pairings.where(:tournament_id => tournament, :team1_id => registration.id).any?
  end
  
  def as_json(*args)
    super(:only => [:id, :current_points, :current_victory_points, :played_games, :extra_points, :penalty_points]).merge(:player_name => name, :player_full_name => name, :army => '' )
  end
end
