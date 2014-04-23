class CreatePetitionDeliveries < ActiveRecord::Migration
  def change
    create_table :petition_deliveries do |t|
      t.integer :petition_id

      t.timestamps
    end
    add_index :petition_deliveries, :petition_id
  end
end
