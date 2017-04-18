class RestaurantsController < ApplicationController
  before_action :authenticate_user!, only: [:index,:show,:location]
  before_action :find_specific_restaurant, only: [:show, :location]

  def index
    session.delete(:cart)
    @restaurants = Restaurant.all
    favorites = Favorite.where(user_id: current_user.id, created_at: 1.week.ago..Time.current).present? || Favorite.where(user_id: current_user.id)
    menu_ids = favorites.group(:menu_id).order('count_menu_id DESC').limit(3).count(:menu_id).keys
    @favorites = menu_ids.map{ |id| Favorite.find_by(menu_id: id) }
    @recommends_info = []
    recommends_ids = []
    other_users_likes = []
    c_restaurants = []
    o_restaurants = []

    current_user_likes = current_user.likes
    current_user_likes.each do |c|
      item = c.restaurant_id
      c_restaurants << item
    end

    users = User.all
    other_users = users.reject { |u| u.id == current_user.id }
    other_users.each do |user|
      other_user_likes = user.likes
      other_user_likes.each do |o|
        item = o.restaurant_id
        o_restaurants <<  item
      end
    end

    if c_restaurants & o_restaurants
      recommend = o_restaurants - c_restaurants
      recommends_ids += recommend
    end

    recommends_ids.each do |r|
      restaurant = Restaurant.find(r)
      @recommends_info << restaurant
    end
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
