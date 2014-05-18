class CreateFunds < ActiveRecord::Migration
  def change
    create_table :funds do |t|
      t.boolean :admin_approved, null: false, default: false
      t.boolean :active, null: false, default: false
      t.integer :goal
      t.integer :stretch_goal
      t.datetime :end_date
      t.text :body
      t.string :title
      t.integer :initiative_id
      t.integer :total_donations, null: false, default: 0
      
      t.integer :user_id

      t.timestamps
    end
    add_index :funds, :initiative_id
    add_index :funds, :end_date
    add_index :funds, :active
    add_index :funds, :user_id
  end
end
