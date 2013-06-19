require 'test_helper'

class PostsControllerTest < ActionController::TestCase
	def setup
		@topic = topics(:sports)
		@post = posts(:one)
		@user = users(:admin)
		@user.password = "12345"
		@user.send(:encrypt_password)
		@user.save!
		login(@user.username, @user.password)
	end

	def test_index
		assert_raise(AbstractController::ActionNotFound){get :index}
	end

  def test_new_post
  	get :new, :topic_id => @topic
    assert_response :success
  end

  def test_create_post
  	assert_difference("Post.count") do
  		post :create, :topic_id => @topic, :post => { :content => "Test content", :title  => "Test title"}
  	end

  	assert_redirected_to topic_post_path(assigns(:topic), assigns(:post))
  end

  def test_show_post
  	get :show, :id => @post, :topic_id => @topic
  	assert_response :success
  end

  def test_edit_post
  	get :show, :id => @post, :topic_id => @topic
  	assert_response :success
  end

  def test_update_post
  	put :update, :id => @post, :topic_id => @topic, :post => { :content => "Test content new", :title  => "Test title new"}
  	assert_redirected_to topic_post_path(@topic, assigns(:post))
  end

  def test_destroy_post
  	assert_difference("Post.count", -1) do
  		delete :destroy, :id => @post, :topic_id => @topic
  	end

  	assert_redirected_to category_topic_path(@topic.category, @topic)
  end
end
