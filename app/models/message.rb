class Message < ApplicationRecord
  belongs_to :sender, class_name: 'User', foreign_key: 'user_id'
  belongs_to :conversation, dependent: :destroy
  belongs_to :listing, optional: true
  validates :body, :sender, :conversation, presence: true
end
