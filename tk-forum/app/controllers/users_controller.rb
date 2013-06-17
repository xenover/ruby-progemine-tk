class UsersController < ApplicationController
  def new
    add_breadcrumb "Sign up"
    @user = User.new()
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, :notice => "Sign-up successful!"
    else
      render "new"
    end
  end
end
