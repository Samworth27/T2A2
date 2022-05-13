# frozen_string_literal: true

# Documentatation
module Listings
  class CategoriesController < ApplicationController
    def index
      @category = Category.first
    end

    def show
      @category = Category.friendly.find(params[:id])
      @items = @category.all_descendants.collect(&:items).flatten.sort
    end
  end
end
