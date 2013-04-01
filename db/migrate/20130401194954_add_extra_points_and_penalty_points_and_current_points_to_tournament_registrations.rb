class AddExtraPointsAndPenaltyPointsAndCurrentPointsToTournamentRegistrations < ActiveRecord::Migration
  def change
    add_column :tournament_registrations, :extra_points, :integer, :default => 0
    add_column :tournament_registrations, :penalty_points, :integer, :default => 0
    add_column :tournament_registrations, :current_points, :integer, :default => 0
    add_column :tournament_registrations, :played_games, :integer, :default => 0
  end
end
