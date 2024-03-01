class UsersController < ApplicationController
  def new
    # ログイン済みならユーザ作成画面にはアクセスできない
    if logged_in?
      redirect_to root_url
    end

    @user = User.new
  end

  def create(user)
    @user = User.new(user.permit(:first_name, :last_name, :email, :password, :password_confirmation, :bio, :avatar, :gender))

    if @user.save
      redirect_to new_user_session_path, notice: 'ユーザー登録に成功しました。ログインしてください。'
    else
      render :new
    end
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
