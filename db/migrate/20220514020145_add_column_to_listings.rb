class AddColumnToListings < ActiveRecord::Migration[7.0]
  def change
    add_column :listings, :headline, :string
  end
end
