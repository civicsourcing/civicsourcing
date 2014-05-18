class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :workroom_id
      t.string :name
      t.boolean :completed, null: false, default: false
      
      t.integer :user_id

      t.timestamps
    end

    add_index :tasks, :workroom_id
    add_index :tasks, :user_id
  end
end
