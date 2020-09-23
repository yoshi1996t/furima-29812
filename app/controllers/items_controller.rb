class ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
  end

  private
  def item_params
    params.require(:item).permit(:image, :name, :info, :category_id, :status_id, :postage_id,:prefecture_id, :schduled_delivery_id, :price).merge(user_id: current_user.id)
  end 

end
