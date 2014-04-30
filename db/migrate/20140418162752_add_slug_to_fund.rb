class AddSlugToFund < ActiveRecord::Migration
  def change
    add_column :funds, :slug, :string
    add_index :funds, :slug
  end
end
