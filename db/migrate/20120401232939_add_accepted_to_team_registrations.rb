class AddAcceptedToTeamRegistrations < ActiveRecord::Migration
  def change
    add_column :team_registrations, :accepted, :boolean, :default => false
  end
end
