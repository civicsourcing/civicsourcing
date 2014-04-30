class AddFeaturedToFund < ActiveRecord::Migration
  def change
    add_column :funds, :featured, :boolean, null: false, default: false
    add_index :funds, :featured
  end
end
