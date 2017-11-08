class FixColumns < ActiveRecord::Migration[5.1]
  def change
    remove_column :products, :last_updated
    remove_column :products, :updated_by
  end
end
