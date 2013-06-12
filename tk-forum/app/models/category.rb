class Category < ActiveRecord::Base
  attr_accessible :name

  belongs_to :user
  has_many :topics, :dependent => :delete_all

  validates_presence_of :name

  scope :sort_alpha, :order => :name
  scope :sort_prt, order("categories.priority DESC")
end
