class AddLeagueIdToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :league_id, :string
  end
end
