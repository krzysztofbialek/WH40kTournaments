class DeleteTeamRegistrations < ActiveRecord::Migration
  def change
    drop_table :team_registrations
  end
end
