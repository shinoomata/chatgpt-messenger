class SessionsController < ApplicationController
  def new
    if Rails.env.development? && !session[:user_id]
      fake_create
    else
      # ログインページを表示するためのアクション
    end
  end

  def auth_twitter2
    redirect_to '/auth/twitter2'
  end

  def create
    begin
      auth_info = request.env["omniauth.auth"]
      Rails.logger.debug "Auth Info: #{auth_info.inspect}"

      user = User.find_or_create_from_auth(auth_info)
      session[:user_id] = user.id
      redirect_to new_diary_path, notice: 'ログインに成功しました'
    rescue => e
      Rails.logger.error "Authentication error: #{e.message}"
      redirect_to root_path, alert: 'ログインに失敗しました'
    end
  end

  def destroy
    reset_session
    redirect_to root_path, status: :see_other
  end

  def failure
    redirect_to root_path, alert: 'ログインに失敗しました'
  end

  private

  def fake_create
    user = User.find_or_create_by(uid: '12345', nickname: 'testuser')
    session[:user_id] = user.id
    redirect_to new_diary_path
  end
end
