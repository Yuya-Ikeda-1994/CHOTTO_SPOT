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
      redirect_to root_path, notice: 'ユーザー登録に成功しました'
    else
      render :new
    end
  end
end
