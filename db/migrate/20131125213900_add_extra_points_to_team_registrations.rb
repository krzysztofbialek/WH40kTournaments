class AddExtraPointsToTeamRegistrations < ActiveRecord::Migration
  def change
    add_column :team_registrations, :extra_points, :integer, :default => 0
  end
end
