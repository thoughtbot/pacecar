require 'test_helper'

class PresenceTest < ActiveSupport::TestCase

  setup do
    @not_null = Factory :user, :first_name => 'Fake'
    @null = Factory :user, :first_name => nil
  end

  test "set the correct expected values for a _present column method" do
    assert_equal [@not_null], User.first_name_present
  end

  test "set the correct expected values for a _missing column method" do
    assert_equal [@null], User.first_name_missing
  end

  test "not setup methods for boolean columns" do
    assert_raise(NoMethodError) { User.admin_missing }
    assert_raise(NoMethodError) { User.admin_present }
  end

end
