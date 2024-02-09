class SpotsController < ApplicationController

  before_action :require_login, only: [:new, :create, :edit, :update, :destroy]

  def index
    @spots = Spot.all.includes(:user).order(created_at: :desc)
  end

  def new
    @spot = Spot.new
    @spot.spot_images.build
  end

  def create
    @spot = current_user.spots.new(spot_params)
    if @spot.save
      redirect_to spots_path, notice: "投稿しました"
    else
      render :new
    end
  end

  def show
    @spot = Spot.find(params[:id])
  end

  private 

  def spot_params
    params.require(:spot).permit(:spot_name, :address, :latitude, :longitude, :comment, spot_images_attributes: [:id, :image, :_destroy])
  end

  def require_login
    unless logged_in?
      flash[:error] = "投稿するにはログインが必要です。"
      redirect_to new_user_session_path # ログインページへのパスを指定
    end
  end
end

