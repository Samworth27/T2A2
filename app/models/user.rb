# frozen_string_literal: true

class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :trackable#, :confirmable

  has_one_attached :avatar
  validates :avatar, file_size: { less_than_or_equal_to: 5.megabytes }, file_content_type: { allow: ['image/jpeg', 'image/png', 'image/gif'] }

  def export
    super(%i[email encrypted_password])
  end
end
