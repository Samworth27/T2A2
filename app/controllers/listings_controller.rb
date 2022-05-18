# frozen_string_literal: true

class ListingsController < ApplicationController

  
  def index; end

  def show; end

  def edit
    @user = current_user
  end

  def create
    @user = current_user
  end
end
