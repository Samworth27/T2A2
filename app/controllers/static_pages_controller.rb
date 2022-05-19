# frozen_string_literal: true

class StaticPagesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
  end
  
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
