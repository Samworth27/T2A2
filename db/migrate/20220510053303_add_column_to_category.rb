# frozen_string_literal: true

class AddColumnToCategory < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :display, :string
  end
end
