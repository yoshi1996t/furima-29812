class OrdersController < ApplicationController
  before_action :set_item, only: [:index, :create]
  before_action :sign_in_required, only: [:index]
  before_action :purchased, only: [:index]
  before_action :seller, only: [:index]
  before_action :authenticate_user!, except: [:index]

  def index
    @order_shape = OrderShape.new
  end

  def create
    @order_shape = OrderShape.new(order_params)
    if @order_shape.valid?
      pay_item
      @order_shape.save
      redirect_to root_path
    else
      render 'index'
    end
  end

  def done
    @order = Order.find(params[:id])
    @order.update(order_id: current_user.id)
  end

  private

  def order_params
    params.require(:order_shape).permit(:post_code, :prefecture_id, :city, :municipality, :building_name, :phone_number).merge(user_id: current_user.id, token: params[:token], item_id: params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,           # 商品の値段
      card: order_params[:token],    # カードトークン
      currency: 'jpy'                # 通貨の種類（日本円）
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

  def sign_in_required
    redirect_to new_user_registration_path unless user_signed_in?
  end

  def purchased
    redirect_to root_path unless @item.order.blank?
  end

  def seller
    redirect_to root_path if current_user.id == @item.user_id
  end
end
