class CreateUserConversations < ActiveRecord::Migration[7.0]
  def change
    create_table :user_conversations do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :conversation, null: false, foreign_key: true

      t.timestamps
    end
    add_index :user_conversations, %i[user_id conversation_id], unique: true
  end
end
