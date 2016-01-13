class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create

  def create
    if user = User.from_omniauth(request.env['omniauth.auth'])
      session[:user_id] = user.id
      redirect_to waste_analysis_path
    else
      redirect_to root_path
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end