class AddScoreToCommunity < ActiveRecord::Migration
  def change
    add_column :communities, :score, :integer, null: false, default: 0
    add_index :communities, :score
  end
end
