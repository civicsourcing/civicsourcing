class CreateFundRewards < ActiveRecord::Migration
  def change
    create_table :fund_rewards do |t|
      t.integer :fund_id
      t.integer :minimum_donation
      t.text :description
      t.integer :limit
      t.integer :fund_donations_count, null: false, default: 0

      t.timestamps
    end
    add_index :fund_rewards, :fund_id
  end
end
