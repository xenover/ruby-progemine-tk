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

  has_many :categories
  has_many :topics
  has_many :posts
  has_many :comments
  #has_one :user_settings

  # authority levels
  ADMIN_LEVEL = 2
  MOD_LEVEL = 1
  REGULAR_LEVEL = 0

  def self.authenticate(username, password)
  	user = find_by_username(username)
  	if User.valid_password?(password, user)
  		user
  	else
  		nil
  	end
  end
  
  def moderator?
    authority_level == MOD_LEVEL || admin?
  end

  def admin?
    authority_level == ADMIN_LEVEL
  end

  def regular?
    authority_level == REGULAR_LEVEL
  end

  def status
    case authority_level
    when ADMIN_LEVEL
      "Admin"
    when MOD_LEVEL
      "Moderator"
    else
      "Forum user"
    end
  end
  
  private
  
  def encrypt_password
  	if password.present?
  		self.password_salt = BCrypt::Engine.generate_salt
  		self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
  	end
  end

  def self.valid_password?(pswd, u)
  	u && u.password_hash == BCrypt::Engine.hash_secret(pswd, u.password_salt)
  end
end