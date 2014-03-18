class CreateInitiatives < ActiveRecord::Migration
  def change
    create_table :initiatives do |t|
      t.string :name
      t.string :slug
      t.text :description
      t.integer :community_id

      t.integer :upload_id

      t.timestamps
    end
    add_index :initiatives, :community_id
    add_index :initiatives, :slug,             :unique => true
  end
end
