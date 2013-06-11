class TopicsController < ApplicationController
	def new
		add_category_breadcrumbs
		add_breadcrumb "New topic"
		redirect_to root_url unless current_user && current_user.admin?
		@topic = Topic.new()
		@cat = Category.find(params[:category_id])
	end

	def create
		@cat = Category.find(params[:category_id])
		@topic = Topic.new(params[:topic])
    @topic.user = current_user
    @topic.category = @cat
  	if @topic.save
  		redirect_to @cat, :notice => "Added new topic #{@topic.name}"
  	else
  		render "new"
  	end
	end

	def show
		@topic = Topic.find(params[:id])
		add_category_breadcrumbs
		add_breadcrumb @topic.name
	end

	def edit
		@topic = Topic.find(params[:id])
		@cat = @topic.category
		add_category_breadcrumbs
		add_breadcrumb "Edit #{@topic.name}"
	end

	def update
		@topic = Topic.find(params[:id])
		@topic.update_attributes(params[:topic])
		redirect_to [@topic.category, @topic]
	end

	def add_category_breadcrumbs
		@cat = Category.find(params[:category_id])
		add_breadcrumb @cat.name, category_path(@cat)
	end
end
