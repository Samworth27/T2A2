class Message < ApplicationRecord
  belongs_to :originator, class_name: 'User'
  belongs_to :recipient, class_name: 'User'
  # has_many :received_messages, class_name: 'Message', foreign_key: 'recipient_id'
  def other_user(user)
    user == originator ? recipient : originator
  end
end
