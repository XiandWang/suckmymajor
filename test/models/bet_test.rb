require 'test_helper'

class BetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
  	@user = users(:michael)
  	@bet = Bet.new(status: "studying", proof:"", lying: false, user_id: @user.id)
  end

  test "should be valid" do
  	puts @bet.errors.full_messages
  	assert @bet.valid?
  end

  test "user id should be present" do
  	@bet.user_id = nil
  	assert_not @bet.valid?
  end

end
