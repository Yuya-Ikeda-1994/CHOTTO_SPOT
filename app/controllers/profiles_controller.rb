class ProfilesController < ApplicationController
  before_action :set_user, only: %i[edit update]

  def show;end

  def edit;end

  def update
    if @user.update(user_params)
      redirect_to profile_path ,notice: t('profiles.update.success')
    else
      flash[:error] = t('profiles.update.fall')
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end


  def user_params
    params.require(:user).permit(:first_name,:last_name, :email, :bio, :avater, :avater_cache, :gender)
  end
end