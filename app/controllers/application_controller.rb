class ApplicationController < ActionController::Base
  helper_method :log_in, :current_user, :log_out

  # ログイン
  def log_in(user)
    session[:user_id] = user.id
  end

  # 現在ログイン中のユーザーのセッションを返すメソッド
  def current_user
    if(user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    end
  end

  # ログアウト
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

end
