class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.string :name
      t.string :rank
      t.datetime :start_date
      t.string :city

      t.timestamps
    end
  end
end
