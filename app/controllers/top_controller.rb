class TopController < ApplicationController
  def index
    session.delete(:cart)
  end
end
