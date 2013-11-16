class CreateTeamRegistrations < ActiveRecord::Migration
  def change
    create_table :team_registrations do |t|
      t.integer :tournament_id
      t.boolean :payment_sent
      t.boolean :rosters_sent
      t.boolean :rosters_valid
      t.string :name
      t.integer :penalty_points
      t.integer :current_points
      t.integer :played_games
      t.integer :current_victory_points
      t.datetime :paid_at
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
