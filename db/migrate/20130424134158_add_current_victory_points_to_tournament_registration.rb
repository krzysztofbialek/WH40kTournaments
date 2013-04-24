class AddCurrentVictoryPointsToTournamentRegistration < ActiveRecord::Migration
  def change
    add_column :tournament_registrations, :current_victory_points, :integer, :default => 0
  end
end
