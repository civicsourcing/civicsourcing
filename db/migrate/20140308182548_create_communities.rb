class CreateCommunities < ActiveRecord::Migration
  def change
    create_table :communities do |t|
      t.string :name
      t.string :slug
      t.boolean :private, null: false, default: false

      t.integer :upload_id

      t.integer :completed_initiatives, null: false, default: 0

      t.integer :community_category_id
      t.integer :user_id

      t.timestamps
    end
    add_index :communities, :name
    add_index :communities, :community_category_id
    add_index :communities, :private
    add_index :communities, :slug,             :unique => true
    add_index :communities, :user_id
  end
end
