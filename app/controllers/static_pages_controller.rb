class StaticPagesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    @category = Category.first
  end

  def trader
    authorize :static_page, :trader?
  end

  def moderator
    authorize :static_page, :moderator?
  end

  def admin
    authorize :static_page, :admin?
  end

  def new; end

  def create
    # book = Book.create!(book_params)
    # if book.valid?
    # redirect_to book
    # else
    # flash.now[:alert] = book.errors.full_messages.join('<br>')
    # render 'new'
    # end
  end
end
