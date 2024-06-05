class SessionsController < ApplicationController
  def new
    # ログインページを表示するためのアクション
  end

  def auth_twitter2
    redirect_to '/auth/twitter2'
  end

  def create
    user = User.find_or_create_from_auth(request.env["omniauth.auth"])
    session[:user_id] = user.uid
    redirect_to new_diary_path
  end

  def destroy
    reset_session
    redirect_to root_path, status: :see_other
  end

  def failure
    redirect_to root_path, alert: 'ログインに失敗しました'
  end
end
