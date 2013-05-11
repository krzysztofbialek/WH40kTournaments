class AddPaidAtToTournamentRegistrations < ActiveRecord::Migration
  def change
    add_column :tournament_registrations, :paid_at, :datetime
  end
end
