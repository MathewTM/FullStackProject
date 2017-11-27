class ChangeToCode < ActiveRecord::Migration[5.1]
  def change
    remove_column :provinces, :abbreviation
    add_column :provinces, :code, :string
  end
end
