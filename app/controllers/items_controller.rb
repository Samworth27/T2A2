class ItemsController < ApplicationController
  def show
    @item = Item.friendly.find(params[:id])
    @category = Category.friendly.find(params[:cat_id])
  end
end
