class RemoveAgain < ActiveRecord::Migration[5.1]
  def change
    remove_column :products, :catagory
    add_column :products, :catagory_id, :integer
  end
end
