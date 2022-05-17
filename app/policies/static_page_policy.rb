# frozen_string_literal: true

class StaticPagePolicy < ApplicationPolicy
  attr_reader :user

  def initialize(user, _record)
    @user = user
  end
end
