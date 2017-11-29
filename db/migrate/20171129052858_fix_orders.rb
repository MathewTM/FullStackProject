class FixOrders < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :name
    remove_column :orders, :email
    remove_column :orders, :address
    remove_column :orders, :city
    remove_column :orders, :province
    remove_column :orders, :postal_code

    add_column :orders, :customer_id, :integer
    add_column :orders, :amount, :float
    add_column :orders, :paid, :boolean
  end
end
