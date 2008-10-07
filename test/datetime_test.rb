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
      should "set the correct proxy options for a _before datetime column method" do
        assert @class.respond_to? :created_at_before
        proxy_options = { :conditions => ['"users".created_at < ?', @time] }
        assert_equal proxy_options, @class.created_at_before(@time).proxy_options
      end
      should "set the correct proxy options for a after_ datetime column method" do
        assert @class.respond_to? :created_at_after
        proxy_options = { :conditions => ['"users".created_at > ?', @time] }
        assert_equal proxy_options, @class.created_at_after(@time).proxy_options
      end
    end
    context "with in_past and in_future methods" do
      setup do
        @now = Time.now
        Time.stubs(:now).returns @now
      end
      should "set the correct proxy options for a _in_past datetime column method" do
        assert @class.respond_to? :created_at_in_past
        proxy_options = { :conditions => ['"users".created_at < ?', @now] }
        assert_equal proxy_options, @class.created_at_in_past.proxy_options
      end
      should "set the correct proxy options for a _in_future datetime column method" do
        assert @class.respond_to? :created_at_in_future
        proxy_options = { :conditions => ['"users".created_at > ?', @now] }
        assert_equal proxy_options, @class.created_at_in_future.proxy_options
      end
    end
    context "with _inside and _outside methods" do
      setup do
        @start = 3.days.ago
        @stop = 2.days.ago
      end
      should "set the correct proxy options for a _inside datetime column method" do
        assert @class.respond_to? :created_at_inside
        proxy_options = { :conditions => ['"users".created_at > ? and "users".created_at < ?', @start, @stop] }
        assert_equal proxy_options, @class.created_at_inside(@start, @stop).proxy_options
      end
      should "set the correct proxy options for a _in_future datetime column method" do
        assert @class.respond_to? :created_at_outside
        proxy_options = { :conditions => ['"users".created_at < ? and "users".created_at > ?', @start, @stop] }
        assert_equal proxy_options, @class.created_at_outside(@start, @stop).proxy_options
      end
    end
    context "with year month and day methods" do
      setup do
        @year = '2000'
        @month = '01'
        @day = '01'
      end
      should "set the correct proxy options for a _in_year datetime column method" do
        assert @class.respond_to? :created_at_in_year
        proxy_options = { :conditions => ['year("users".created_at) = ?', @year] }
        assert_equal proxy_options, @class.created_at_in_year(@year).proxy_options
      end
      should "set the correct proxy options for a _in_month datetime column method" do
        assert @class.respond_to? :created_at_in_month
        proxy_options = { :conditions => ['month("users".created_at) = ?', @month] }
        assert_equal proxy_options, @class.created_at_in_month(@month).proxy_options
      end
      should "set the correct proxy options for a _in_day datetime column method" do
        assert @class.respond_to? :created_at_in_day
        proxy_options = { :conditions => ['day("users".created_at) = ?', @day] }
        assert_equal proxy_options, @class.created_at_in_day(@day).proxy_options
      end
    end
  end

end
