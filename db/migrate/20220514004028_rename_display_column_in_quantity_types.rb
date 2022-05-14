class RenameDisplayColumnInQuantityTypes < ActiveRecord::Migration[7.0]
  def change
    rename_column :quantity_types, :display, :unit_of_measurement
  end
end
