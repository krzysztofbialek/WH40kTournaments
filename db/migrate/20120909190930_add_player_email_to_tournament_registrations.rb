class AddPlayerEmailToTournamentRegistrations < ActiveRecord::Migration
  def change
    add_column :tournament_registrations, :player_email, :string
  end
end
