class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: -> { Rails.env.development? }  
  helper_method :current_user, :user_signed_in?, :owner?

  private

  def authenticate_user!
    unless user_signed_in?
    redirect_to login_path, alert: 'ログインしてください'
    end
  end

  def owner?(diary)
    diary.user == current_user
  end

  def current_user
    return unless session[:user_id]
    @current_user ||= User.find_by(uid: session[:user_id])
  end

  def user_signed_in?
    !!current_user
  end
end
