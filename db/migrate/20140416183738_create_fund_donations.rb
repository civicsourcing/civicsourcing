class CreateFundDonations < ActiveRecord::Migration
  def change
    create_table :fund_donations do |t|
      t.integer :fund_id
      t.integer :user_id
      t.integer :fund_reward_id
      t.integer :amount
      t.boolean :paid, default: false, null: false

      t.timestamps
    end
    add_index :fund_donations, :fund_id
    add_index :fund_donations, :user_id
    add_index :fund_donations, :fund_reward_id
    add_index :fund_donations, :paid
  end
end
