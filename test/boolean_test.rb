require File.join(File.dirname(__FILE__), 'test_helper')

class BooleanTest < Test::Unit::TestCase

  context "A class which has included Pacecar" do
    setup do
      @class = User
    end
    should "respond to boolean column method" do
      assert @class.respond_to? :admin
    end
    should "set correct proxy options for boolean column method" do
      proxy_options = { :conditions => { :admin => true } }
      assert_equal proxy_options, @class.admin.proxy_options
    end
    should "respond to not_ boolean column method" do
      assert @class.respond_to? :not_admin
    end
    should "set correct proxy options for not_ boolean column method" do
      proxy_options = { :conditions => { :admin => false } }
      assert_equal proxy_options, @class.not_admin.proxy_options
    end
  end

end
