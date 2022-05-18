class RenameMessageColumnInMessages < ActiveRecord::Migration[7.0]
  def change
    rename_column :messages, :message, :body
  end
end
