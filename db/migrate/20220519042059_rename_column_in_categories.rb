class RenameColumnInCategories < ActiveRecord::Migration[7.0]
  def change
    rename_column :categories, :category_id, :parent_id
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
