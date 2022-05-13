class Item < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :category
  has_one_attached :image
  has_many :listings, dependent: :destroy
end
