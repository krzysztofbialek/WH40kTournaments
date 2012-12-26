class AddCurrentRoundAndNumberOfRoundsToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :current_round, :integer,   :default => 0
    add_column :tournaments, :number_of_rounds, :integer
  end
end
