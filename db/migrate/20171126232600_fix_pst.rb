class FixPst < ActiveRecord::Migration[5.1]
  def change
    add_column :provinces, :pst, :integer
  end
end
