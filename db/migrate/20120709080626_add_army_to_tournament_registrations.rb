class AddArmyToTournamentRegistrations < ActiveRecord::Migration
  def change
    add_column :tournament_registrations, :army, :string
  end
end
