require File.join(File.dirname(__FILE__), 'test_helper')

class DurationTest < Test::Unit::TestCase

  context "A class which has included Pacecar" do
    setup do
      @class = User
    end
    context "with duration methods" do
      setup do
        @days = 14
      end
      should "respond to a duration_between datetime column method" do
        assert @class.respond_to? :duration_between
      end
      should "set the correct proxy options for a duration_between datetime column method" do
        proxy_options = { :select => 'datediff("users".created_at, "users".updated_at) as duration' }
        assert_equal proxy_options, @class.duration_between(:created_at, :updated_at).proxy_options
      end
      should "set the correct proxy options for a with_duration_of datetime column method" do
        proxy_options = { :conditions => ['duration = ?', @days] }
        assert_equal proxy_options, @class.with_duration_of(@days).proxy_options
      end
      should "set the correct proxy options for a with_duration_over datetime column method" do
        proxy_options = { :conditions => ['duration >= ?', @days] }
        assert_equal proxy_options, @class.with_duration_over(@days).proxy_options
      end
      should "set the correct proxy options for a with_duration_under datetime column method" do
        proxy_options = { :conditions => ['duration <= ?', @days] }
        assert_equal proxy_options, @class.with_duration_under(@days).proxy_options
      end
    end
  end

end
