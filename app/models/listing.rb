# frozen_string_literal: true

class Listing < ApplicationRecord
  belongs_to :item
  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'
  belongs_to :measurement
  validates :headline, :item, :quantity, :measurement, :start_dtg, :finish_dtg, presence: true
  def measurement_display
    quantity > 1 ? measurement.plural : measurement.unit
  end

  def item_name
    if measurement.measurement_for == 'count'
      quantity > 1 ? item.plural : item.name
    else
      item.plural
    end
  end
end
