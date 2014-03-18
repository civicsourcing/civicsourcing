class CreateWorkrooms < ActiveRecord::Migration
  def change
    create_table :workrooms do |t|
      t.integer :initiative_id

      t.timestamps
    end
    add_index :workrooms, :initiative_id
  end
end
