class ReviewsController < ApplicationController
  def create
    binding.pry
    if Review.create(review_params)
      redirect_to "/restaurants"
    else
      flash.now[:alert] = '注文に失敗しました'
    end
  end

  private

  def review_params
    params.require(:review).permit(:review).merge(user_id: current_user.id)
  end
end
