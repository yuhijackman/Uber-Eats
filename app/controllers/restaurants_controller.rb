class RestaurantsController < ApplicationController
  before_action :authenticate_user!, only: [:index,:show,:location]

  def index
    session.delete(:cart)
    @restaurants = Restaurant.all
    favorites = Favorite.where(user_id: current_user.id, created_at: 1.week.ago..Time.current)
    if favorites.present?
      menu_ids = favorites.group(:menu_id).order('count_menu_id DESC').limit(3).count(:menu_id).keys
      @favorites = menu_ids.map{ |id| Favorite.find_by(menu_id: id) }
    else
      @favorites = Favorite.where(user_id: current_user.id).last(3)
    end
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
