class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @menus = @restaurant.menus
  end

  def search
    @restaurants = Restaurant.where('name || genre LIKE ?', "%#{params[:keyword]}%")
  end

end
