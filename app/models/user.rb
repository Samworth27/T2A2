# frozen_string_literal: true

class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :destroy
  has_many :sent_messages, class_name: 'Message', foreign_key: 'originator_id'
  has_many :received_messages, class_name: 'Message', foreign_key: 'recipient_id'

  def export
    super(%i[email encrypted_password])
  end
  def messages
    sent_messages + received_messages
  end

  def new_message(recipient, message)
    Message.create!(originator: self, recipient:, message:)
  end
end
