class DislikesController < ApplicationController
  def create
    Dislike.create(user_id: current_user.id, restaurant_id: params[:restaurant_id])
    redirect_to "/restaurants"
  end
end
