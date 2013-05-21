class CreatePlayedTournaments < ActiveRecord::Migration
  def change
    create_table :played_tournaments do |t|
      t.integer :player_id
      t.integer :tournament_id
      t.integer :place
      t.integer :points

      t.timestamps
    end
  end
end
