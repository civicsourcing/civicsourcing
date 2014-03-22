class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :workroom_id
      t.string :name
      t.boolean :completed, null: false, default: false

      t.timestamps
    end

    add_index :tasks, :workroom_id
  end
end
