class TopicsController < ApplicationController
	def new
		@cat = Category.find(params[:category_id])
		redirect_to root_url unless current_user && current_user.admin?
		@topic = Topic.new()
	end

	def create
		@cat = Category.find(params[:category_id])
		@topic = Topic.new(params[:topic])
    @topic.user = current_user
    @topic.category = @cat
  	if @topic.save
  		redirect_to root_url, :notice => "Added new topic #{@topic.name}"
  	else
  		render "new"
  	end
	end

	def show
		@topic = Topic.find(params[:id])
	end
end
