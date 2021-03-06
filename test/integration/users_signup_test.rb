require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid user" do
	  get signup_path
	  assert_no_difference 'User.count' do 
	  	post users_path, user: {name:"", email: "user@invalid", password:"foo",
	  							password_confirmation: "bar"}
	  end
	  assert_template 'users/new'
  end

  test "valid user" do
    get signup_path
    assert_difference 'User.count', 1 do
    	post_via_redirect users_path, user: {name: "xiandong", email: "xiw@seas.upenn.edu",
    										password: "iverson", password_confirmation:"iverson"}
    end
    assert_template 'users/show'
  end
end
