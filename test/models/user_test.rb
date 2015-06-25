require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
  	@user = User.new(name:"Example User", email:"user@example.com",
  					password:"foobar", password_confirmation:"foobar")
  end

  test "should be valid" do
  	assert @user.valid?
  end

  test "name not valid" do
  	@user.name = "     "
  	assert_not @user.valid?
  end

  test "email should be unique" do
  	user_new = @user.dup
  	user_new.email = @user.email.upcase
  	@user.save
  	assert_not user_new.valid?
  end

  test "authenticated" do
    assert_not @user.authenticated?(:remember, '')
  end
  
 end
