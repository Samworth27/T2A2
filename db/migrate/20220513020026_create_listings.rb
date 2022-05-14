# frozen_string_literal: true

class CreateListings < ActiveRecord::Migration[7.0]
  def change
    create_table :listings do |t|
      t.references :item, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.float :quantity
      t.references :quantity_type, null: false, foreign_key: true
      t.date :start_dtg
      t.date :finish_dtg

      t.timestamps
    end
  end
end
