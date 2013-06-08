class CategoriesController < ApplicationController
  def new
  	redirect_to root_url unless current_user && current_user.admin?
  	@ctg = Category.new()
  end

  def create
  	@ctg = Category.new(params[:category])
    @ctg.user = current_user
  	if @ctg.save
  		redirect_to root_url, :notice => "Added new category #{@ctg.name}"
  	else
  		render "new"
  	end
  end

  def show
    @ctg = Category.find(params[:id])
  end

  def edit
    @ctg = Category.find(params[:id])
  end

  def update
    @ctg = Category.find(params[:id])
    @ctg.update_attributes!(params[:category])
    redirect_to @ctg
  end
end
