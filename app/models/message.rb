class Message < ApplicationRecord
  belongs_to :sender, class_name: 'User', foreign_key: 'user_id'
  belongs_to :conversation
  validates :body, :sender, :conversation, presence: true
end
