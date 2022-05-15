class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.string :display_name
      t.string :first_name
      t.string :last_name
      t.string :country
      t.string :state
      t.string :suburb

      t.timestamps
    end
  end
end
