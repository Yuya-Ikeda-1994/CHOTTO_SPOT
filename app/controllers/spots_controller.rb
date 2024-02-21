class SpotsController < ApplicationController

  before_action :require_login, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_spot, only: [:edit, :update, :destroy]

  def index
    @q = Spot.ransack(params[:q])
    @spots = @q.result.includes(:user, :tags).order(created_at: :desc)
  end

  def new
    @spot = Spot.new
    @spot.spot_images.build
  end

  def create
    @spot = current_user.spots.new(spot_params)
  
    # タグのIDが提供され、かつそれらが有効であることを確認
    if params[:spot][:tag_ids].present? && !Tag.where(id: params[:spot][:tag_ids]).count == params[:spot][:tag_ids].count
      flash[:error] = "指定された一部のタグが見つかりません。"
      render :new and return
    end
  
    if @spot.save
      redirect_to spots_path, notice: "投稿しました"
    else
      render :new
    end
  end
  

  def show
    @spot = Spot.find(params[:id])
    @feedback = Feedback.new
    @feedbacks = @spot.feedbacks.includes(:user).order(created_at: :desc)
  end

  def edit;end
  
  def update
    if @spot.update(spot_params)
      redirect_to @spot, notice: "投稿を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @spot.destroy
    redirect_to spots_path, notice: "投稿を削除しました"
  end

  private 

  def spot_params
    # `tag_ids`が存在しない場合は、デフォルトで空の配列を設定
    params.require(:spot).permit(:spot_name, :address, :latitude, :longitude, :comment, spot_images_attributes: [:id, :image, :_destroy]).tap do |whitelisted|
      whitelisted[:tag_ids] = params[:spot][:tag_ids] || []
    end
  end

  def require_login
    unless logged_in?
      flash[:error] = "投稿するにはログインが必要です。"
      redirect_to new_user_session_path # ログインページへのパスを指定
    end
  end

  def set_spot
    @spot = current_user.spots.find_by(id: params[:id])
  end
end

