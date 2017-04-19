class RestaurantsController < ApplicationController
  before_action :authenticate_user!, only: [:index,:show,:location]
  before_action :find_specific_restaurant, only: [:show, :location]

  def index
    session.delete(:cart)
    @restaurants = Restaurant.where(status: 0)
    @caterings = Restaurant.where(status: 1)
    favorites = Favorite.where(user_id: current_user.id, created_at: 1.week.ago..Time.current)
    if favorites.present?
      menu_ids = favorites.group(:menu_id).order('count_menu_id DESC').limit(3).count(:menu_id).keys
      @favorites = menu_ids.map{ |id| Favorite.find_by(menu_id: id) }
    else
      favorites = Favorite.where(user_id: current_user.id)
      menu_ids = favorites.group(:menu_id).order('count_menu_id DESC').limit(3).count(:menu_id).keys
      @favorites = menu_ids.map{ |id| Favorite.find_by(menu_id: id) }
    end
    @recommends_info = []
    Restaurant.show_recommends(current_user, @recommends_info)
  end

  def show
    @likes = Like.where(restaurant_id: params[:id])
    gon.value = @restaurant.id
    gon.like = @restaurant.like_user(current_user.id)
    @menus = @restaurant.menus
    @catering = Catering.new
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
