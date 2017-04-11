class MenusController < ApplicationController

  def search
    @menu = Menu.find(params[:menu_id])
    respond_to do |format|
      format.json { render json: @menu }
    end
  end

end
