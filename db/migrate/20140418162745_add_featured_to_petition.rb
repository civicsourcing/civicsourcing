class AddFeaturedToPetition < ActiveRecord::Migration
  def change
    add_column :petitions, :featured, :boolean, null: false, default: false
    add_index :petitions, :featured
  end
end
