# frozen_string_literal: true

class Item < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_ancestry

  has_one_attached :image
  has_many :listings, dependent: :destroy
end
