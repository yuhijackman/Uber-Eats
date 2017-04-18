class LikesController < ApplicationController

  def create
    like = Like.create(user_id: current_user.id, restaurant_id: params[:restaurant_id])
    @likes = Like.where(restaurant_id: params[:restaurant_id])
    respond_to do |format|
      format.json { render json: @likes }
    end
  end

  def destroy
    like = current_user.likes.find_by(restaurant_id: params[:restaurant_id])
    like.destroy
    @likes = Like.where(restaurant_id: params[:restaurant_id])
    respond_to do |format|
      format.json { render json: @likes }
    end
  end

end
