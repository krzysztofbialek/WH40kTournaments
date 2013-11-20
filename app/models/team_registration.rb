#encoding: utf-8
class TeamRegistration < ActiveRecord::Base
  attr_accessible :team_registration_players_attributes, :current_points, :current_victory_points, :deleted_at, :name, :city, :paid_at, :payment_send, :penalty_points, :played_games, :roster_send, :roster_valid, :tournament_id

  belongs_to :tournament  
  has_many :team_registration_players
  has_many :players, through: :team_registration_players

  accepts_nested_attributes_for :team_registration_players
  
  def as_json(*args)
    super(:only => [:id, :current_points, :current_victory_points, :played_games, :extra_points, :penalty_points]).merge(:player_name => name, :player_full_name => name, :army => '' )
  end
end
