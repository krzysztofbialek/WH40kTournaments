class AddDeletedAtToTournamentRegistrations < ActiveRecord::Migration
  def change
    add_column :tournament_registrations, :deleted_at, :datetime
  end
end
