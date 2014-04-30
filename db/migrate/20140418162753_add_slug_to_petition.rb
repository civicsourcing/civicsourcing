class AddSlugToPetition < ActiveRecord::Migration
  def change
    add_column :petitions, :slug, :string
    add_index :petitions, :slug
  end
end
