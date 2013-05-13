class User < ActiveRecord::Base
  attr_accessible :username, :email, :first_name, :last_name, :birthday, :about, :password, :password_confirmation

  attr_accessor :password

  validates_presence_of :username
  validates_uniqueness_of :username

  validates_presence_of :email
  validates_uniqueness_of :email

  validates_presence_of :birthday

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create

  before_save :encrypt_password

  def self.authenticate(username, password)
  	user = find_by_username(username)
  	if User.valid_password(password, user)
  		user
  	else
  		nil
  	end
  end
  
  private
  
  def encrypt_password
  	if password.present?
  		self.password_salt = BCrypt::Engine.generate_salt
  		self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
  	end
  end

  def self.valid_password(pswd, u)
  	u && u.password_hash == BCrypt::Engine.hash_secret(pswd, u.password_salt)
  end
end
