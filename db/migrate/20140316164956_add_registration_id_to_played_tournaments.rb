class AddRegistrationIdToPlayedTournaments < ActiveRecord::Migration
  def change
    add_column :played_tournaments, :registration_id, :integer
  end
end
