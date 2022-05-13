class CreateQuantityTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :quantity_types do |t|
      t.string :description

      t.timestamps
    end
  end
end
