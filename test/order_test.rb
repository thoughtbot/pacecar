require File.join(File.dirname(__FILE__), 'test_helper')

class OrderTest < Test::Unit::TestCase

  context "A class which has included Pacecar" do
    setup do
      @class = User
    end
    context "with order methods" do
      should "set the correct expected values for a by_ column method with no args" do
        assert @class.respond_to?(:by_first_name)
        expected = ["\"users\".first_name asc"]
        assert_equal expected, @class.by_first_name.order_values
      end
      should "set the correct expected values for a by_ column method with asc args" do
        assert @class.respond_to?(:by_first_name)
        expected = ["\"users\".first_name asc"]
        assert_equal expected, @class.by_first_name(:asc).order_values
      end
      should "set the correct expected values for a by_ column method with desc args" do
        assert @class.respond_to?(:by_first_name)
        expected = ["\"users\".first_name desc"]
        assert_equal expected, @class.by_first_name(:desc).order_values
      end
    end
  end

end
