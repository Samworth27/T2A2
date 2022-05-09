# frozen_string_literal: true

class StaticPagePolicy
  attr_reader :user

  def initialize(user, _record)
    @user = user
  end

  def trader?
    user.has_role?(:trader)
  end

  def moderator?
    user.has_role?(:moderator)
  end

  def admin?
    user.has_role?(:admin)
  end
end
