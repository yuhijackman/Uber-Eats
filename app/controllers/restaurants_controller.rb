class RestaurantsController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def index
    @restaurants = Restaurant.all
    @favorites = Favorite.where(user_id: current_user.id)
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @menus = @restaurant.menus
  end

  def search
    word = params[:keyword]
    @restaurants = Restaurant.including_name_or_genre(word)
  end

end
