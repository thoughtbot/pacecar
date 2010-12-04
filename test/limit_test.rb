require 'test_helper'

class LimitTest < Test::Unit::TestCase

  context "A class which has included Pacecar" do
    setup do
      @class = User
    end
    context "with order methods" do
      should "set the correct expected values for a by_ column method" do
        assert @class.respond_to?(:limited)
        expected = 10
        assert_equal expected, @class.limited.limit_value
      end
      should "set the correct expected values for a by_ column method when sent args" do
        assert @class.respond_to?(:limited)
        expected = 20
        assert_equal expected, @class.limited(20).limit_value
      end
      should "set the correct expected values for a by_ column method when per_page defined" do
        assert @class.respond_to?(:limited)
        @class.expects(:per_page).returns 30
        expected = 30
        assert_equal expected, @class.limited.limit_value
      end
    end
  end

end
