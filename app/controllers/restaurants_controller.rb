class RestaurantsController < ApplicationController
  before_action :authenticate_user!, only: [:index,:show,:location]
  before_action :find_specific_restaurant, only: [:show, :location]

  def index
  end

  def show
    @likes = Like.where(restaurant_id: params[:id])
    gon.value = @restaurant.id
    gon.like = @restaurant.like_user(current_user.id)
    @menus = @restaurant.menus
  end

  def search
    word = params[:keyword]
    @restaurants = Restaurant.including_name_or_genre(word)
  end

  def location
    @review = Review.new
    respond_to do |format|
      format.html
      format.json { render json: @restaurant }
    end
  end

  def find_specific_restaurant
    @restaurant = Restaurant.find(params[:id])
  end



end
