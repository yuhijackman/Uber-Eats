class OrdersController < ApplicationController

  def create
    @order = Order.new(order_params)
    if @order.save
    else
      flash.now[:alert] = '注文に失敗しました'
    end
  end

  private

  def order_params
    params.permit(:menu_id).merge(user_id: current_user.id)
  end
end
