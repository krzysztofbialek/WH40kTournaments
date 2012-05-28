class AddTournamentIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :tournament_id, :integer
  end
end
