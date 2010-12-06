require 'test_helper'

class DurationTest < ActiveSupport::TestCase

  setup do
    @same_user = Factory :user, :created_at => 15.days.ago.midnight, :updated_at => 15.days.ago.midnight
    @updated_user = Factory :user, :created_at => 15.days.ago.midnight, :updated_at => 1.days.ago.midnight
  end

  test "set the correct expected values for a with_duration_of datetime column method" do
    assert_equal [@updated_user], User.with_duration_of(14, :created_at, :updated_at)
  end

  test "set the correct expected values for a with_duration_over datetime column method" do
    assert_equal [@updated_user], User.with_duration_over(10, :created_at, :updated_at)
  end

  test "set the correct expected values for a with_duration_under datetime column method" do
    assert_equal [@same_user], User.with_duration_under(10, :created_at, :updated_at)
  end

end
