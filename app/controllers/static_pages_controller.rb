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
  def new

  end

  def create
    #book = Book.create!(book_params)
    #if book.valid?
      #redirect_to book
    #else
      #flash.now[:alert] = book.errors.full_messages.join('<br>)
      # render 'new'
    #end
  end
end
