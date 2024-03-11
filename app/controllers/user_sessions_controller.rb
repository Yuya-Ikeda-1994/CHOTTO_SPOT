class UserSessionsController < ApplicationController
  def new
  end

  def create
    @user = login(user_params[:email], user_params[:password])

    if @user
      redirect_back_or_to(root_path, notice: t('user_sessions.create.success'))
    else
      flash.now[:alert] = t('user_sessions.create.fall')
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: t('user_sessions.destroy.success')
  end

  private

  def user_params
    params.require(:user_session).permit(:email, :password)
  end
end