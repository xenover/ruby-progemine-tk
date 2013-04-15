class Post < ActiveRecord::Base
  attr_accessible :content, :name, :author_email, :title, :tags_attributes

  validates :name,  :presence => true
  validates :title, :presence => true, :length => {:minimum => 5}
  validates_format_of :author_email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :allow_blank => true
  
  has_many :comments, :dependent => :destroy
  has_many :tags
  
  accepts_nested_attributes_for :tags, :allow_destroy => :true, :reject_if => proc{|attrs| attrs.all? {|k, v| v.blank?}}
end
