require 'test_helper'

class NumericTest < ActiveSupport::TestCase

  setup do
    @young = Factory :user, :age => 11, :rating => 10.0
    @legal = Factory :user, :age => 21, :rating => 7.5
    @older = Factory :user, :age => 31, :rating => 5.0
  end

  test "set the correct expected values for a _greater_than column method for an integer column" do
    assert_equal [@older], User.age_greater_than(21)
  end

  test "set the correct expected values for a _greater_than_or_equal_to column method for an integer column" do
    assert_equal [@legal, @older], User.age_greater_than_or_equal_to(21)
  end

  test "set the correct expected values for a _less_than column method for an integer column" do
    assert_equal [@young], User.age_less_than(21)
  end

  test "set the correct expected values for a _less_than_or_equal_to column method for an integer column" do
    assert_equal [@young, @legal], User.age_less_than_or_equal_to(21)
  end

  test "set the correct expected values for a _greater_than column method for a float column" do
    assert_equal [@young], User.rating_greater_than(7.5)
  end

  test "set the correct expected values for a _greater_than_or_equal_to column method for a float column" do
    assert_equal [@young, @legal], User.rating_greater_than_or_equal_to(7.5)
  end

  test "set the correct expected values for a _less_than column method for a float column" do
    assert_equal [@older], User.rating_less_than(7.5)
  end

  test "set the correct expected values for a _less_than_or_equal_to column method for a float column" do
    assert_equal [@legal, @older], User.rating_less_than_or_equal_to(7.5)
  end

end
