require 'test_helper'

class UserMajorRelationshipTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
  	@relationship = UserMajorRelationship.new(user_id: 1, major_id: 2)
  end

  test "should be valid" do 
  	assert @relationship.valid?
  end
end
