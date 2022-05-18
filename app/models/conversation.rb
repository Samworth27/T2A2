class Conversation < ApplicationRecord
  has_many :user_conversations, dependent: :destroy
  has_many :users, through: :user_conversations
  has_many :messages

  def self.between(user1, user2)
    conversations = user1.conversations.to_a.intersection(user2.conversations.to_a)
    if conversations.empty?
      conversation = Conversation.new
      conversation.users << [user1, user2]
      conversation.save
    else
      conversation = conversations[0]
    end
    conversation
  end

  def other_user(user)
    users.excluding(user).first
  end

  def last_message_dtg
    messages.last.created_at
  end
end
