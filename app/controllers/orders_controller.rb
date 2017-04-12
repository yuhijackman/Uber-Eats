class OrdersController < ApplicationController

  def create
    session[:cart].each do |cart|
      @order = Order.new(menu_id: cart["id"], user_id: current_user.id)
      @order.save
      menu_id = cart["id"]
      user = Order.where(user_id: current_user.id)
      favorites = user.where(menu_id: menu_id)
      judge = Favorite.find_by(menu_id: menu_id)
      if favorites.count > 5 && judge == nil
        Favorite.create(menu_id: menu_id, restaurant_id: cart["restaurant_id"], user_id: current_user.id)
      end
    end
    session.delete(:cart)
    redirect_to "/orders/#{@order.id}"
  end

  def show
    @order = Order.find(params[:id])
    @review = Review.new
    @restaurant = @order.menu.restaurant
    respond_to do |format|
      format.html
      format.json { render json: @restaurant }
    end
  end

  def add
    session[:cart] ||= []
    cart = Menu.find(params[:menu_id])
    session[:cart] << cart
    redirect_to '/restaurants'
  end

  def cartList
    respond_to do |format|
      format.html { redirect_to restaurants_path }
      format.json { render json: session[:cart] }
    end
  end

end
