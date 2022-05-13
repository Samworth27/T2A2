class AddColumnToQuantityType < ActiveRecord::Migration[7.0]
  def change
    add_column :quantity_types, :display, :string
  end
end
