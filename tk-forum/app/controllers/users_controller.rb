class UsersController < ApplicationController

  def index
    redirect_to root_url, :notice => "You don't have permission to view users" unless current_user &&current_user.admin?
    add_breadcrumb "Users"
    @users = User.all
  end

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
