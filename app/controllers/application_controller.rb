class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  def current_user
    if session[:user_id]
      return User.find(session[:user_id])
    else
      return nil
    end
  end

  def current_user_path
    user_path(current_user.id)
  end

end
