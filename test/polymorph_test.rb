require 'test_helper'

class PolymorphTest < ActiveSupport::TestCase

  setup do
    @owned_by_user = Factory :post, :owner_type => 'User'
    @owned_by_mammal = Factory :post, :owner_type => 'Mammal'
  end

  test "set the correct expected values on a _for column method with Class" do
    assert_equal [@owned_by_user], Post.for_owner_type(User)
  end

  test "set the correct expected values on a _for column method with String" do
    assert_equal [@owned_by_user], Post.for_owner_type('User')
  end

end
