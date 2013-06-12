class Topic < ActiveRecord::Base
	attr_accessible :name

  belongs_to :category
  belongs_to :user

  has_many :posts, :dependent => :delete_all

  scope :sort_alpha, :order => :name
end
