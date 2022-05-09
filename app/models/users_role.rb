# frozen_string_literal: true

class UsersRole < ApplicationRecord
  def export
    super(%i[user_id role_id])
  end
end
