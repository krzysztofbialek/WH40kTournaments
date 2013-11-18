#encoding: utf-8
class TeamRegistration < ActiveRecord::Base
  attr_accessible :current_points, :current_victory_points, :deleted_at, :name, :city, :paid_at, :payment_send, :penalty_points, :played_games, :roster_send, :roster_valid, :tournament_id

  belongs_to :tournament  
  has_many :team_registration_players

  accepts_nested_attributes_for :team_registration_players
end
