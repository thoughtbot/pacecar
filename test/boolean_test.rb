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
  end

end
