class Comment < ActiveRecord::Base
  belongs_to :post
  attr_accessible :body, :commenter
  
  validates :body,      :length => {:minimum => 5}
  validates :commenter, :length => {:minimum => 5}
end
