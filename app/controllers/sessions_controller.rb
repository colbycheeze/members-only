class SessionsController < ApplicationController

  def new
    if logged_in?
      flash[:notice] = "You are already logged in"
      redirect_to root_url
    end
  end

  def create
    user = User.find_by( email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      flash[:notice] = "You have successfully logged in."
      redirect_to root_url
    else
      flash.now[:error] = "Incorrect Login Information"
      render :new
    end
  end

  def destroy
    log_out
    flash[:notice] = "You have successfully logged out."
    redirect_to root_url
  end
end
