class AddTableToTournamentPairings < ActiveRecord::Migration
  def change
    add_column :tournament_pairings, :table, :integer
  end
end
