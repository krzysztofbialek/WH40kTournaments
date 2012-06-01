class CreateTournamentRegistrations < ActiveRecord::Migration
  def change
    create_table :tournament_registrations do |t|
      t.integer :tournament_id
      t.integer :player_id
      t.boolean :payment_send, :default => false
      t.boolean :roster_send,  :default => false
      t.boolean :roster_valid, :default => false

      t.timestamps
    end
  end
end
