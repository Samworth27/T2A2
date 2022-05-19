class AddColumnToMessage < ActiveRecord::Migration[7.0]
  def change
    add_reference :messages, :listing, null: true, foreign_key: true
  end
end
