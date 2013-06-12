class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic
  attr_accessible :content, :title
end