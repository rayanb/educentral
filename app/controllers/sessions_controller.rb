class SessionsController < ApplicationController
  def new
    redirect_to tracks_path if session[:user_id]
  end

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to tracks_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end