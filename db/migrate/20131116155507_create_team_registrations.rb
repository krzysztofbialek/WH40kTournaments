class CreateTeamRegistrations < ActiveRecord::Migration
  def change
    create_table :team_registrations do |t|
      t.integer :tournament_id
      t.boolean :payment_send, :default => false
      t.boolean :roster_send, :default => false
      t.boolean :roster_valid, :default => false
      t.string :name
      t.string :city
      t.integer :penalty_points, :default => 0
      t.integer :current_points, :default => 0
      t.integer :played_games, :default => 0
      t.integer :current_victory_points, :default => 0
      t.datetime :paid_at
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
