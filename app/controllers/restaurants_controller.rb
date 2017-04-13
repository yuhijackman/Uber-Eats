class RestaurantsController < ApplicationController
  before_action :authenticate_user!, only: [:index,:show,:location]

  def index
    session.delete(:cart)
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

  def location
    @restaurant = Restaurant.find(params[:id])
    @review = Review.new
    respond_to do |format|
      format.html
      format.json { render json: @restaurant }
    end
  end

end
