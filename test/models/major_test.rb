require 'test_helper'

class MajorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
  	@major = Major.new(name: "Computer Science")
  end

  test "should be valid" do
  	assert @major.valid?
  end

  
end
