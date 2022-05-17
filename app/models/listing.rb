# frozen_string_literal: true

class Listing < ApplicationRecord
  belongs_to :item
  belongs_to :user
  belongs_to :measurement
end
