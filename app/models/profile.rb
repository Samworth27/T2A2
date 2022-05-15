# frozen_string_literal: true

class Profile < ApplicationRecord
  validates :display_name, :first_name, :last_name, :country, :state, :suburb, presence: true
  belongs_to :user
end
