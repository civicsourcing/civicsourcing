class AddCustomerHrefToUser < ActiveRecord::Migration
  def change
    add_column :users, :customer_href, :string
  end
end
