class TopicsController < ApplicationController
	def new
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
	end

	def edit
		@topic = Topic.find(params[:id])
		@cat = @topic.category
	end

	def update
		@tc = Topic.find(params[:id])
		@tc.update_attributes(params[:topic])
		redirect_to [@tc.category, @tc]
	end
end
