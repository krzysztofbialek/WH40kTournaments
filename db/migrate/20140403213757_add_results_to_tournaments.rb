class AddResultsToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :results, :string
  end
end
