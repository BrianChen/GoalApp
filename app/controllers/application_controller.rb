class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :require_login

  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def login(user)
    session[:session_token] = user.session_token
  end

  def logout
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  def require_login
    unless current_user
      redirect_to new_session_url
    end
  end
end
