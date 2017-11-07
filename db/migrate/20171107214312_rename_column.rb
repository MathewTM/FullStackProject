class RenameColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :products, :lastupdated, :last_updated
    rename_column :products, :updatedby, :updated_by
  end
end
