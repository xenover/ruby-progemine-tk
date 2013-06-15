class CategoriesController < ApplicationController

  def index
    add_breadcrumb 'Categories'

    @all = Category.sort_prt
  end

  def new
    add_breadcrumb 'New category'

  	redirect_to root_url unless current_user && current_user.admin?
  	@ctg = Category.new()
  end

  def create
  	@ctg = Category.new(params[:category])
    @ctg.user = current_user
    last_cat = Category.last
    @ctg.priority = last_cat.nil? ? 0 : last_cat.priority + 1
  	if @ctg.save
  		redirect_to root_url, :notice => "Added new category #{@ctg.name}"
  	else
  		render "new"
  	end
  end

  def show
    @ctg = Category.find(params[:id])

    add_breadcrumb @ctg.name
  end

  def edit
    @ctg = Category.find(params[:id])

    add_breadcrumb "Edit #{@ctg.name}"
  end

  def update
    @ctg = Category.find(params[:id])
    @ctg.update_attributes!(params[:category])
    redirect_to @ctg
  end
end
