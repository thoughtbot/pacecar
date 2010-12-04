require 'test_helper'

class PolymorphTest < Test::Unit::TestCase

  context "A class which has included Pacecar" do
    setup do
      @class = Post
    end
    context "with polymorph methods" do
      should "set the correct expected values on a _for column method with Class" do
        assert @class.respond_to?(:for_owner_type)
        expected = ["\"posts\".owner_type = 'User'"]
        assert_equal expected, @class.for_owner_type(User).where_values
      end
      should "set the correct expected values on a _for column method with String" do
        assert @class.respond_to?(:for_owner_type)
        expected = ["\"posts\".owner_type = 'User'"]
        assert_equal expected, @class.for_owner_type('User').where_values
      end
    end
  end

end
