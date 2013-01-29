class AddPausingToTournamentPairings < ActiveRecord::Migration
  def change
    add_column :tournament_pairings, :pausing, :boolean, :default => false
  end
end
