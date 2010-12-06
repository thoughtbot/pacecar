require 'test_helper'

class OrderTest < ActiveSupport::TestCase

  setup do
    @first = Factory :user, :first_name => 'Abe'
    @last  = Factory :user, :first_name => 'Zed'
  end

  test "set the correct expected values for a by_ column method with no args" do
    assert_equal [@first, @last], User.by_first_name
  end

  test "set the correct expected values for a by_ column method with asc args" do
    assert_equal [@first, @last], User.by_first_name(:asc)
  end

  test "set the correct expected values for a by_ column method with desc args" do
    assert_equal [@last, @first], User.by_first_name(:desc)
  end

end
