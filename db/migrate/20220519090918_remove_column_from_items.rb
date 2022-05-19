class RemoveColumnFromItems < ActiveRecord::Migration[7.0]
  def change
    remove_column :items, :category_id, :string
    add_column :items, :ancestry, :string
    add_index :items, :ancestry
  end
end
