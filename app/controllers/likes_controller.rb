class LikesController < ApplicationController
  before_action :set_spot
    
  def create
    @like = @spot.likes.create(user_id: current_user.id)
    respond_to do |format|
      format.js 
    end
  end
    
  def destroy
    @like = @spot.likes.find_by(user_id: current_user.id)
    @like.destroy
    respond_to do |format|
      format.js
    end
  end

  private
    def set_spot
      @spot = Spot.find(params[:spot_id])
    end
end
