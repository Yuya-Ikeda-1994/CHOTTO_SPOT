class UserSessionsController < ApplicationController
  def new
  end

  def create
    @user = login(user_params[:email], user_params[:password])

    if @user
      redirect_back_or_to(root_path)
    else
      flash.now[:alert] = "サインインに失敗しました。再度お試しください"
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: 'サインアウトしました'
  end

  private

  def user_params
    params.require(:user_session).permit(:email, :password)
  end
end