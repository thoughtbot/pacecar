require File.join(File.dirname(__FILE__), 'test_helper')

class LimitTest < Test::Unit::TestCase

  context "A class which has included Pacecar" do
    setup do
      @class = User
    end
    context "with order methods" do
      should "set the correct proxy options for a by_ column method" do
        assert @class.respond_to? :limited
        proxy_options = { :limit => 10 }
        assert_equal proxy_options, @class.limited.proxy_options
      end
      should "set the correct proxy options for a by_ column method when sent args" do
        assert @class.respond_to? :limited
        proxy_options = { :limit => 20 }
        assert_equal proxy_options, @class.limited(20).proxy_options
      end
      should "set the correct proxy options for a by_ column method when per_page defined" do
        assert @class.respond_to? :limited
        @class.expects(:per_page).returns 30
        proxy_options = { :limit => 30 }
        assert_equal proxy_options, @class.limited.proxy_options
      end
    end
  end

end
