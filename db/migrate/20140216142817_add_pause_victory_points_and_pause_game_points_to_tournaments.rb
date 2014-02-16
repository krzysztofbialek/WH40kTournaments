class AddPauseVictoryPointsAndPauseGamePointsToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :pause_victory_points, :integer, default: 5 
    add_column :tournaments, :pause_game_points, :integer, default: 15
  end
end
