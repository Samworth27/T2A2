# frozen_string_literal: true

# Documentatation
class CategoriesController < ApplicationController
  def index
    @category = Category.first
  end

  def show
    @category = Category.friendly.find(params[:id])
    @items = @category.descendants
    @listings = Listing.where(category: @category.subtree)
  end

  def category_params
    params.fetch(:category, {}).permit(:image)
  end
end
