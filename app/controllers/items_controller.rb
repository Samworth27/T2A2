# frozen_string_literal: true

class ItemsController < ApplicationController
  def show
    @item = Item.includes(:listings).friendly.find(params[:id])
    @category = Category.friendly.find(params[:cat_id])
    @listings = @item.listings
  end

  def edit
    @item = Item.friendly.find(params[:id])
  end

  def update
    @item = Item.friendly.find(params[:id])
    if @item.update!(item_params)
      flash[:notice] = 'Item has been updated'
      redirect_to edit_item_path(@item)
      # format.html { redirect_to item_url(@item), notice: "item was successfully updated." }
      # format.json { render :show, status: :ok, location: @item }
    else
      flash[:alert] = item.errors.full_messages.join('<br>')
      render 'edit'
      # format.html { render :edit, status: :unprocessable_entity }
      # format.json { render json: @item.errors, status: :unprocessable_entity }
    end
  end

  private

  def item_params
    params.fetch(:item, {}).permit(:image)
  end
end
