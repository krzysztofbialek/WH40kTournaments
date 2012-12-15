class CreateTournamentPairings < ActiveRecord::Migration
  def change
    create_table :tournament_pairings do |t|
      t.integer :player1_id
      t.integer :player2_id
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
