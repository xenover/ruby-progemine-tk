require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup  
  	@regular = users(:regular)
  	@regular.password = "1234567"
  	@mod = users(:mod)
  	@mod.password = "abcdefg"
  	@admin = users(:admin)
  	@admin.password = "qwerty"
  end

  def test_user_authority
  	assert_equal @regular.regular?, true
  	assert_equal @mod.moderator?, true
  	assert_equal @admin.admin?, true
  	assert_equal @admin.moderator?, true
  	assert_not_equal @mod.admin?, true
  end

  def test_user_status
  	assert_equal @regular.status, "Forum user"
  	assert_equal @mod.status, "Moderator"
  	assert_equal @admin.status, "Admin"
  end

  def test_password_encryption
  	assert_raise(NoMethodError){@regular.encrypt_password}
  	@regular.send(:encrypt_password)
  	assert_not_nil @regular.password_salt
  	assert_not_nil @regular.password_hash
  end

  def test_authentication
  	@regular.send(:encrypt_password)
  	@regular.save!
  	assert_equal User.valid_password?(@regular.password, @regular), true
  	assert_equal User.authenticate(@regular.username, @regular.password), @regular
  	assert_nil User.authenticate(@regular.username, "random_password")
  end
end
