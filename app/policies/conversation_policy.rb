class ConversationPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def new?
    create?
  end

  def create?
    true
  end

  def edit?
    update?
  end

  def destroy?
    true
  end

  def update?
    false
  end
  
  class Scope < Scope
    def resolve_admin
      scope.where(sender: user)
    end
  end
end