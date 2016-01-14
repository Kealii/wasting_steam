class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create

  def create
    if user = User.from_omniauth(request.env['omniauth.auth'])
      session[:user_id] = user.id
      redirect_to waste_analysis_path
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  def failure
    flash.alert = "Invalid Credentials. Please Try Again."
    redirect_to root_path
  end
end