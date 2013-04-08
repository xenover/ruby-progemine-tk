class Post < ActiveRecord::Base
  attr_accessible :content, :name, :author_email, :title, :tags_attributes

  validates :name,  :presence => true
  validates :title, :presence => true, :length => {:minimum => 5}
  validates :author_email, :presence => true, :length => {:minimum => 10}
  
  has_many :comments, :dependent => :destroy
  has_many :tags
  
  accepts_nested_attributes_for :tags, :allow_destroy => :true, :reject_if => proc{|attrs| attrs.all? {|k, v| v.blank?}}
end
