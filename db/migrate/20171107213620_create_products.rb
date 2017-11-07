class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :type
      t.decimal :price
      t.integer :quantity
      t.timestamp :lastupdated
      t.string :updatedby

      t.timestamps
    end
  end
end
