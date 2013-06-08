class Category < ActiveRecord::Base
  attr_accessible :name

  belongs_to :user
  has_many :topics

  validates_presence_of :name
end
