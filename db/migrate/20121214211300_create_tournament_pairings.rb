class CreateTournamentPairings < ActiveRecord::Migration
  def change
    create_table :tournament_pairings do |t|
      t.integer :player1
      t.integer :player2
      t.integer :player1_game_points
      t.integer :player2_game_points
      t.integer :player1_match_points
      t.integer :player2_match_points
      t.integer :round
      t.integer :tournament_id

      t.timestamps
    end
  end
end
