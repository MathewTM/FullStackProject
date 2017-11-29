class AddColumnsToCustomers < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :email, :string
    add_column :customers, :password, :string
    add_column :customers, :address, :string
    add_column :customers, :city, :string
    add_column :customers, :province_id, :integer
    add_column :customers, :postal_code, :string
  end
end
