class CateringsController < ApplicationController

  def create
    binding.pry
    @catering = Catering.new(catering_params)
    if @catering.save
      redirect_to "/caterings/#{@catering.id}"
    else
      flash.now[:alert] = '配達日時を指定して下さい'
    end
  end

  def show
    
  end


  private

  def catering_params
    params.permit(:menu_id, :arrived_at).merge(user_id: current_user.id)
  end
end
