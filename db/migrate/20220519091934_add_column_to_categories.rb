class AddColumnToCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :plural, :string
  end
end