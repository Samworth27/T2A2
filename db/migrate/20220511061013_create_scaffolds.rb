# frozen_string_literal: true

class CreateScaffolds < ActiveRecord::Migration[7.0]
  def change
    create_table :scaffolds, &:timestamps
  end
end
