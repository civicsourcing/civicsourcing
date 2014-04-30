class AddFeaturedToInitiative < ActiveRecord::Migration
  def change
    add_column :initiatives, :featured, :boolean, null: false, default: false
    add_index :initiatives, :featured
  end
end
