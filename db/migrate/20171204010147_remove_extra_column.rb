class RemoveExtraColumn < ActiveRecord::Migration[5.1]
  def change
    remove_column :products, :catagory_id
  end
end
