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
  
    unless @user
      create_user_from(provider)
      return # 処理をここで終了させる
    end
  
    redirect_to root_path, notice: "#{provider.titleize}でログインしました"
  end

  def create_user_from(provider)
    @user = create_from(provider)
    if @user.persisted?
      reset_session
      auto_login(@user)
      redirect_to root_path, notice: "#{provider.titleize}でログインしました"
      return # この行を追加して、メソッドから抜け出す
    end
  
    # ユーザーの作成に失敗した場合、こちらのブロックが実行されます。
    # rescueブロックからこの位置に到達することはありません。
    flash[:alert] = @user.errors.full_messages.join(', ')
    redirect_to new_user_session_path
  rescue ActiveRecord::NotNullViolation
    flash[:alert] = t('errors.messages.null_violation')
    redirect_to new_user_session_path
  end

  private

  def auth_params
    params.permit(:code, :provider, :denied, :scope, :authuser, :prompt)
  end

end
