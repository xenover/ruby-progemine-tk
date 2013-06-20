class SessionsController < ApplicationController
  def new
    add_breadcrumb "Log in"
  end

  def create
  	user = User.authenticate(params[:username], params[:password])
  	if user
  		session[:user_id] = user.id
  		redirect_to root_url, :notice => "Log in successful!"
  	else
  		flash.now.alert = "Invalid email or password! Please check your input"
  		render "new"
  	end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to :back, :notice => "Log out successful!"
  end
end
