class AddSlugToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :slug, :string
    add_index :tournaments, :slug
  end
end
