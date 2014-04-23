class CreatePetitionSignatures < ActiveRecord::Migration
  def change
    create_table :petition_signatures do |t|
      t.integer :petition_id
      t.integer :user_id
      t.text :comment

      t.timestamps
    end
    add_index :petition_signatures, [:user_id, :petition_id], unique: true
  end
end
