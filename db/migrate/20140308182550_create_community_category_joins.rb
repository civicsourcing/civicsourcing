class CreateCommunityCategoryJoins < ActiveRecord::Migration
  def change
    create_table :community_category_joins do |t|
      t.integer :community_id
      t.integer :community_category_id

      t.timestamps
    end
    add_index :community_category_joins,
      [:community_id, :community_category_id],
      unique: true,
      name: "community_category_joins_on_join"
  end
end
