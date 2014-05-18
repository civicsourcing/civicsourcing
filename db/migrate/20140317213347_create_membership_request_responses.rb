class CreateMembershipRequestResponses < ActiveRecord::Migration
  def change
    create_table :membership_request_responses do |t|
      t.integer :membership_request_id
      t.boolean :accepted, null: false, default: false
      t.text :notes
      
      t.integer :user_id

      t.timestamps
    end
    add_index :membership_request_responses, :user_id
  end
end
