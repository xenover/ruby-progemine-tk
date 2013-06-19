class PostsController < ApplicationController

	def new
		add_parent_breadcrumbs
		add_breadcrumb "New post"

		@topic = Topic.find(params[:topic_id])
		@post = Post.new
	end

	def create
		@topic = Topic.find(params[:topic_id])
		@post = Post.new(params[:post])
    @post.user = current_user
    @post.topic = @topic
  	if @post.save
  		redirect_to [@topic, @post], :notice => "Added new post #{@post.title}"
  	else
  		render "new"
  	end
	end

	def show
		@post = Post.find(params[:id])
		@comment = Comment.new()

		add_parent_breadcrumbs
		add_breadcrumb @post.title
	end

	def edit
		@topic = Topic.find(params[:topic_id])
		@post = Post.find(params[:id])

		add_parent_breadcrumbs
		add_breadcrumb "Edit post"
	end

	def update
		@post = Post.find(params[:id])
		@post.update_attributes(params[:post])
		redirect_to [@post.topic, @post], :notice => "Updated post #{@post.title}"
	end

	def destroy
		post = Post.find(params[:id])
		title = post.title
		topic = post.topic

		post.destroy
		redirect_to [topic.category, topic], :notice => "Deleted post #{title}"
	end

	def add_parent_breadcrumbs
		@topic = Topic.find(params[:topic_id])
		add_breadcrumb @topic.category.name, @topic.category
		add_breadcrumb @topic.name, [@topic.category, @topic]
	end
end
