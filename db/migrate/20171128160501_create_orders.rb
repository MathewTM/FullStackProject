class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :name
      t.string :email
      t.string :address
      t.string :city
      t.integer :province
      t.string :postal_code

      t.timestamps
    end
  end
end
