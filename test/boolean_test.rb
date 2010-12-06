require 'test_helper'

class BooleanTest < ActiveSupport::TestCase

  setup do
    @one = Factory :user, :admin => true
    @two = Factory :user, :admin => true
    @three = Factory :user, :admin => true
    @four = Factory :user, :admin => false
    @five = Factory :user, :admin => false
  end

  test "set the correct expected values for a boolean column method" do
    assert_equal [@one, @two, @three], User.admin
  end

  test "set the correct expected values for a not_ boolean column method" do
    assert_equal [@four, @five], User.not_admin
  end

  test "return correct value for balance class method when true greater than false" do
    assert_equal 1, User.admin_balance
  end

  test "return correct value for balance class method when true less than false" do
    3.times { Factory :user, :admin => false }
    assert_equal -2, User.admin_balance
  end

end
