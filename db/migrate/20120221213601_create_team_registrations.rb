class CreateTeamRegistrations < ActiveRecord::Migration
  def change
    create_table :team_registrations do |t|
      t.integer :team_id
      t.boolean :payment,        :default => false
      t.boolean :rosters,        :default => false
      t.boolean :rosters_valid,  :defautl => false

      t.timestamps
    end
  end
end
