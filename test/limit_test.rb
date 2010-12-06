require 'test_helper'

class LimitTest < ActiveSupport::TestCase

  setup do
    50.times { Factory :user }
  end

  test "set the correct expected values for a by_ column method" do
    assert_equal 50, User.count
    assert_equal 10, User.limited.all.size
  end

  test "set the correct expected values for a by_ column method when sent args" do
    assert_equal 50, User.count
    assert_equal 20, User.limited(20).all.size
  end

  test "set the correct expected values for a by_ column method when per_page defined" do
    User.expects(:per_page).returns 30
    assert_equal 50, User.count
    assert_equal 30, User.limited.all.size
  end

end
