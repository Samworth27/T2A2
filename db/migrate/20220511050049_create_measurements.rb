class CreateMeasurements < ActiveRecord::Migration[7.0]
  def change
    create_table :measurements do |t|
      t.string :unit
      t.string :plural
      t.string :abbreviation
      t.string :measurement_for
      t.string :prefix
      t.integer :power

      t.timestamps
    end
  end
end
