class ItemsController < ApplicationController
  before_action :move_to_index, only: :new

  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :info, :category_id, :status_id, :postage_id, :prefecture_id, :schduled_delivery_id, :price).merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to new_user_session_path
  end
end
