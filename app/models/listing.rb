# frozen_string_literal: true

class Listing < ApplicationRecord
  belongs_to :item
  belongs_to :user
  has_one :measurement
end
