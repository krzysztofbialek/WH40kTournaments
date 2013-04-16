class AddStateToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :state, :string
  end
end
