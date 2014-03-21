class CreateCommunityCategories < ActiveRecord::Migration
  def change
    create_table :community_categories do |t|
      t.string :name

      t.timestamps
    end
    add_index :community_categories, :name
  end
end
