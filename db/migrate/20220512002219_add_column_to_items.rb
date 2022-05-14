# frozen_string_literal: true

class AddColumnToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :plural, :string
  end
end
