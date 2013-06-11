class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user

  before_filter :set_initial_breadcrumbs

  private 

  def current_user 
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def set_initial_breadcrumbs
    add_breadcrumb "Home", root_path
  end
end
