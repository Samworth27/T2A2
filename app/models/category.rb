# frozen_string_literal: true

class Category < ApplicationRecord
  extend FriendlyId
  has_ancestry

  friendly_id :plural, use: :slugged
  has_one_attached :image
  has_many :listings, dependent: :destroy

  def self.items
    Category.all
  end
end
