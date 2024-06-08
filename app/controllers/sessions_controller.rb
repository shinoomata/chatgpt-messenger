class SessionsController < ApplicationController
  def new
    # ログインページを表示するためのアクション
  end

  def auth_twitter2
    redirect_to '/auth/twitter2'
  end

  def create
    begin
      auth_info = request.env["omniauth.auth"]
      Rails.logger.debug "Auth Info: #{auth_info.inspect}"

      user = User.find_or_create_from_auth(auth_info)
      session[:user_id] = user.uid
      redirect_to new_diary_path, notice: 'ログインに成功しました'
    rescue => e
      Rails.logger.error "Authentication error: #{e.message}"
      redirect_to root_path, alert: 'ログインに失敗しました'
    end

  def destroy
    reset_session
    redirect_to root_path, status: :see_other
  end

  def failure
    redirect_to root_path, alert: 'ログインに失敗しました'
  end
end
