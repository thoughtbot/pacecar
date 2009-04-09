require File.join(File.dirname(__FILE__), 'test_helper')

class BooleanTest < Test::Unit::TestCase

  context "A class which has included Pacecar" do
    setup do
      @class = User
    end
    should "set the correct proxy options for a boolean column method" do
      assert @class.respond_to?(:admin)
      proxy_options = { :conditions => ['"users".admin = ?', true] }
      assert_equal proxy_options, @class.admin.proxy_options
    end
    should "set the correct proxy options for a not_ boolean column method" do
      assert @class.respond_to?(:not_admin)
      proxy_options = { :conditions => ['"users".admin = ?', false] }
      assert_equal proxy_options, @class.not_admin.proxy_options
    end
    context "With boolean column scopes that can count" do
      setup do
        assert @class.respond_to?(:admin_balance)
        @true_mock = mock
        @false_mock = mock
        @class.expects(:admin).returns @true_mock
        @class.expects(:not_admin).returns @false_mock
      end
      should "return correct value for balance class method when true greater than false" do
        @true_mock.expects(:count).returns 5
        @false_mock.expects(:count).returns 2
        assert_equal 3, @class.admin_balance
      end
      should "return correct value for balance class method when true less than false" do
        @true_mock.expects(:count).returns 2
        @false_mock.expects(:count).returns 5
        assert_equal -3, @class.admin_balance
      end
    end
  end

end
