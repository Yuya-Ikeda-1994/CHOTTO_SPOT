class OauthsController < ApplicationController

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider] || "google"
    if auth_params[:denied].present?
      redirect_to root_path, notice: "#{provider.titleize}でログインしました"
      return
    end
    Rails.logger.info "Before login_from: @user=#{@user.inspect}"
    @user = login_from(provider)
    Rails.logger.info "After login_from: @user=#{@user.inspect}"
    create_user_from(provider) unless (@user = login_from(provider))
    redirect_to root_path, notice: "#{provider.titleize}でログインしました"
  end

  private

  def auth_params
    params.permit(:code, :provider, :denied, :scope, :authuser, :prompt)
  end

  def create_user_from(provider)
    @user = create_from(provider)
    if @user.persisted?
      reset_session
      auto_login(@user)
    else
      redirect_to new_user_session_path, alert: t('oauths.create_user_from.failure')
    end
  end
end
