class AddAcceptedAtToTeamRegistrations < ActiveRecord::Migration
  def change
    add_column :team_registrations, :accepted_at, :datetime
  end
end
