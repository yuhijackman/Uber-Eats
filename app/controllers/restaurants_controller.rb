class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @menus = @restaurant.menus
  end

  def search
    word = params[:keyword]
    @restaurants = Restaurant.where("name like '%" + word + "%'").or(Restaurant.where("genre like '%" + word + "%'"))

    # @restaurants = Restaurant.including_name_or_genre(word)
  end

end
