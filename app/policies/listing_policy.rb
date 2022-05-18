class ListingPolicy < ApplicationPolicy
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
    true
  end
  
  class Scope < Scope
    def resolve_admin
      scope.where(owner: user)
    end
  end
end