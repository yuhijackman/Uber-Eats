class CateringsController < ApplicationController

  def create
    @catering = Catering.new(catering_params)
    if @catering.save
      redirect_to "/caterings/#{@catering.id}"
    else
      flash.now[:alert] = '配達日時を指定して下さい'
    end
  end

  def show
    @catering = Catering.find(params[:id])
    @user = @catering.user
    @menu = @catering.menu
  end


  private

  def catering_params
    params.permit(:menu_id, :arrived_at, :address).merge(user_id: current_user.id)
  end
end
