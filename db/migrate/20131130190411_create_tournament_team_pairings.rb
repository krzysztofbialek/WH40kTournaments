class CreateTournamentTeamPairings < ActiveRecord::Migration
  def change
    create_table :tournament_team_pairings do |t|
      t.integer :tournament_id
      t.integer :team1_id
      t.integer :team2_id
      t.integer :team1_match_points
      t.integer :team2_match_points
      t.integer :team1_game_points
      t.integer :team2_game_points
      t.integer :table
      t.boolean :pausing
      t.integer :round

      t.timestamps
    end
  end
end
