class StaticPagesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
  end
  def trader
  end
  def moderator
  end
  def admin
  end
end
