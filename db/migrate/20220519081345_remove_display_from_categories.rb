class RemoveDisplayFromCategories < ActiveRecord::Migration[7.0]
  def change
    remove_column :categories, :display
  end
end
