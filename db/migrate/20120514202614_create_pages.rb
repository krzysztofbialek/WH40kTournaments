class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :tournament_id
      t.string  :slug
      t.string  :title
      t.text    :content

      t.timestamps
    end
  end
end
