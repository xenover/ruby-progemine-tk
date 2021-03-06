class CommentsController < ApplicationController
	def create
		@post = Post.find(params[:post_id])
		@topic = @post.topic
		@comment = Comment.new(params[:comment])
		@comment.post = @post
		@comment.user = current_user
		if @comment.save
  		redirect_to :back, :notice => "Added new comment to #{@post.title}"
  	else
  		redirect_to [@topic, @post], :notice => "Could not save new comment. Please try again!"
  	end
	end

	def destroy
		comment = Comment.find(params[:id])
		post = comment.post
		topic = post.topic
		comment.destroy
		redirect_to [topic, post], :notice => "Comment deleted!"
	end
end
