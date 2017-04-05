class OrdersController < ApplicationController
  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to "/orders/#{@order.id}"
    else
      flash.now[:alert] = '注文に失敗しました'
    end
  end

  def show
    @order = Order.find(params[:id])
    @restaurant = @order.menu.restaurant
    respond_to do |format|
      format.html
      format.json { render json: @restaurant }
    end
  end

  private

  def order_params
    params.permit(:menu_id).merge(user_id: current_user.id)
  end
end
