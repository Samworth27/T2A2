# frozen_string_literal: true

class ListingsController < ApplicationController
  def index; end

  def show
    @listing = Listing.find(params[:id])
    @item = @listing.item
    @category = @item.category
    @measurement = @listing.quantity > 1 ? @listing.measurement.plural : @listing.measurement.unit
    if @listing.measurement.measurement_for == 'count'
      @name = @listing.quantity > 1 ? @item.plural : @item.name
    else
      @name = @item.plural
    end
  end
end
