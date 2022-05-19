# frozen_string_literal: true

class ListingsController < ApplicationController
  def index; end

  def show
    @message = Message.new
    @listing = Listing.find(params[:id])
    @category = @listing.category
  end
end
