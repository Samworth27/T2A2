# frozen_string_literal: true

class Listing < ApplicationRecord

  belongs_to :category
  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'
  belongs_to :measurement
  has_many :messages, dependent: :destroy
  has_one_attached :image
  
  validates :headline, :category, :quantity, :measurement, :start_dtg, :finish_dtg, presence: true
  
  def measurement_display
    quantity > 1 ? measurement.plural : measurement.unit
  end

  def item_name
    if measurement.measurement_for == 'count'
      quantity > 1 ? category.plural : category.name
    else
      category.plural
    end
  end
end
