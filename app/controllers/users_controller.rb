class UsersController < ApplicationController
  def new
    if logged_in?
      redirect_to root_url
    end
    @user = User.new
  end

  def create
    @user = User.new(user_params) 

    if @user.save
      redirect_to new_user_session_path, notice: t('users.create.success') 
    else
      flash.now[:alert] = t('users.create.fall') 
      render :new
    end
  end


  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :bio, :avatar, :gender)
  end

  def guest_login
    if current_user
      redirect_to current_user, alert: "すでにログインしています"  # ログインしている場合はゲストユーザーを作成しない
    else
      user = User.guest_login
      log_in user
      redirect_to root_path, notice: "ゲストとしてログインしました"
    end
  end
end

