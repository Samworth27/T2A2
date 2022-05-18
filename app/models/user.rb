# frozen_string_literal: true

class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :destroy
  
  has_many :user_conversations, dependent: :destroy
  has_many :conversations, through: :user_conversations, dependent: :destroy

  def export
    super(%i[email encrypted_password])
  end
end
