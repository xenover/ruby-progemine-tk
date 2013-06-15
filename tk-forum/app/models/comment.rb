class Comment < ActiveRecord::Base
	attr_accessible :content
	
  belongs_to :user
  belongs_to :post

  validates_presence_of :content
  validates_presence_of :post
  validates_presence_of :user
end
