class Post < ActiveRecord::Base
	attr_accessible :content, :title

  belongs_to :user
  belongs_to :topic

  has_many :comments, :dependent => :delete_all
end
