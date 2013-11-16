class TeamRegistration < ActiveRecord::Base
  attr_accessible :current_points, :current_victory_points, :deleted_at, :name, :paid_at, :payment_sent, :penalty_points, :played_games, :rosters_sent, :rosters_valid, :tournament_id
end
