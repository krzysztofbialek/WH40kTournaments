class CreateRankPlaces < ActiveRecord::Migration
  def change
    create_table :rank_places do |t|
      t.integer :player_id
      t.integer :place
      t.integer :total_points
      t.integer :masters_count
      t.integer :challengers_count
      t.integer :locals_count
      t.integer :leagues_count

      t.timestamps
    end
  end
end
