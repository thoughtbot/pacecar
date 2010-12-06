require 'test_helper'

class RankingTest < ActiveSupport::TestCase

  setup do
    @many = Factory :user
    5.times { Factory :comment, :user => @many }
    @few = Factory :user
    2.times { Factory :comment, :user => @few }
    @none = Factory :user
  end

  test "set the correct expected values on a maximum_ column method" do
    assert_equal [@many, @few], User.maximum_comments
  end

  test "set the correct expected values on a minimum_ column method" do
    assert_equal [@few, @many], User.minimum_comments
  end

end
