class OrdersController < ApplicationController

  def index
    @order = Order.new
  end

  # def create
  #   @order = Order.new(order_params)
  #   if @order.valid?
  #     @order.save
  #     returun redirect_to root_path
  #   else
  #     render 
  # end

end
