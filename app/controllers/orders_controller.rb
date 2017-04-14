class OrdersController < ApplicationController

  def create
    if session[:cart].present?
      session[:cart].each do |cart|
        @order = Order.new(menu_id: cart["id"], user_id: current_user.id)
        @order.save
        Order.auto_favorite(@order, current_user.id)
      end
      restaurant_id = session[:cart][0]["restaurant_id"]
      session.delete(:cart)
      redirect_to "/restaurants/#{restaurant_id}/location"
    else
      @order = Order.new(menu_id: params[:menu_id], user_id: current_user.id)
      @order.save
      Order.auto_favorite(@order, current_user.id)
      redirect_to "/restaurants/#{params[:restaurant_id]}/location"
    end
  end

  def add
    session[:cart] ||= []
    cart = Menu.find(params[:menu_id])
    session[:cart] << cart
    restaurant_id = session[:cart][0]["restaurant_id"]
    redirect_to "/restaurants/#{restaurant_id}"
  end

  def cartList
    respond_to do |format|
      format.html { redirect_to restaurants_path }
      format.json { render json: session[:cart] }
    end
  end

end
