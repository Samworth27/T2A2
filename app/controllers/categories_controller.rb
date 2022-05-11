# frozen_string_literal: true

# Documentatation
class CategoriesController < ApplicationController
  def index
    @category = Category.first
  end

  def show
    @category = Category.friendly.find(params[:id])
  end
end
