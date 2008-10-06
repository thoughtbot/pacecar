require File.join(File.dirname(__FILE__), 'test_helper')

class DatetimeTest < Test::Unit::TestCase

  context "A class which has included Pacecar" do
    setup do
      @class = User
    end
    context "with before and after methods" do
      setup do
        @time = 5.days.ago
      end
      should "respond to _before datetime column method" do
        assert @class.respond_to? :created_at_before
      end
      should "set correct proxy options for _before datetime column method" do
        proxy_options = { :conditions => ['created_at < ?', @time] }
        assert_equal proxy_options, @class.created_at_before(@time).proxy_options
      end
      should "respond to _after datetime column method" do
        assert @class.respond_to? :created_at_after
      end
      should "set correct proxy options for after_ datetime column method" do
        proxy_options = { :conditions => ['created_at > ?', @time] }
        assert_equal proxy_options, @class.created_at_after(@time).proxy_options
      end
    end
    context "with in_past and in_future methods" do
      setup do
        @now = Time.now
        Time.stubs(:now).returns @now
      end
      should "respond to _in_past datetime column method" do
        assert @class.respond_to? :created_at_in_past
      end
      should "set correct proxy options for _in_past datetime column method" do
        proxy_options = { :conditions => ['created_at < ?', @now] }
        assert_equal proxy_options, @class.created_at_in_past.proxy_options
      end
      should "respond to _in_future datetime column method" do
        assert @class.respond_to? :created_at_in_future
      end
      should "set correct proxy options for _in_future datetime column method" do
        proxy_options = { :conditions => ['created_at > ?', @now] }
        assert_equal proxy_options, @class.created_at_in_future.proxy_options
      end
    end
  end

end
