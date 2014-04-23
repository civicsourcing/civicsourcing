class CreatePetitions < ActiveRecord::Migration
  def change
    create_table :petitions do |t|
      t.integer :initiative_id
      t.string :title
      t.text :body
      t.integer :goal
      t.datetime :delivery_date
      t.string :deliver_to
      t.integer :petition_signatures_count, null: false, default: 0
      t.boolean :delivered, null: false, default: false

      t.timestamps
    end
    add_index :petitions, :initiative_id
    add_index :petitions, :delivery_date
    add_index :petitions, :delivered
  end
end
