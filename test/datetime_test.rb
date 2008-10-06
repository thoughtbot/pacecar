require File.join(File.dirname(__FILE__), 'test_helper')

class DatetimeTest < Test::Unit::TestCase

  context "A class which has included Pacecar" do
    setup do
      @class = User
    end
    context "with presence methods" do
      should "respond to datetime column method" do
        assert @class.respond_to? :created_at
      end
      should "set correct proxy options for datetime column method" do
        proxy_options = { :conditions => 'created_at is not null' }
        assert_equal proxy_options, @class.created_at.proxy_options
      end
      should "respond to not_ datetime column method" do
        assert @class.respond_to? :not_created_at
      end
      should "set correct proxy options for not_ datetime column method" do
        proxy_options = { :conditions => 'created_at is null' }
        assert_equal proxy_options, @class.not_created_at.proxy_options
      end
    end
    context "with before and after methods" do
      should "respond to _before datetime column method" do
        assert @class.respond_to? :created_at_before
      end
      should "set correct proxy options for _before datetime column method" do
        time = 5.days.ago
        proxy_options = { :conditions => ['created_at < ?', time] }
        assert_equal proxy_options, @class.created_at_before(time).proxy_options
      end
      should "respond to _after datetime column method" do
        assert @class.respond_to? :created_at_after
      end
      should "set correct proxy options for after_ datetime column method" do
        time = 5.days.ago
        proxy_options = { :conditions => ['created_at > ?', time] }
        assert_equal proxy_options, @class.created_at_after(time).proxy_options
      end
    end
  end

end
