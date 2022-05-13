class Listing < ApplicationRecord
  belongs_to :item
  belongs_to :user
  belongs_to :quantity_type
end
