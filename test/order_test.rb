require File.join(File.dirname(__FILE__), 'test_helper')

class OrderTest < Test::Unit::TestCase

  context "A class which has included Pacecar" do
    setup do
      @class = User
    end
    context "with order methods" do
      should "respond to a by_ datetime column method" do
        assert @class.respond_to? :by_first_name
      end
      should "set the correct proxy options for a by_ column method with no args" do
        proxy_options = { :order => '"users".first_name asc' }
        assert_equal proxy_options, @class.by_first_name.proxy_options
      end
      should "set the correct proxy options for a by_ column method with asc args" do
        proxy_options = { :order => '"users".first_name asc' }
        assert_equal proxy_options, @class.by_first_name(:asc).proxy_options
      end
      should "set the correct proxy options for a by_ column method with desc args" do
        proxy_options = { :order => '"users".first_name desc' }
        assert_equal proxy_options, @class.by_first_name(:desc).proxy_options
      end
    end
  end

end
