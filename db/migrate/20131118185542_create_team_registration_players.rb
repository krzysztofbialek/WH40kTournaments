class CreateTeamRegistrationPlayers < ActiveRecord::Migration
  def change
    create_table :team_registration_players do |t|
      t.integer :team_registration_id
      t.integer :player_id
      t.string :army

      t.timestamps
    end
  end
end
