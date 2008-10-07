require File.join(File.dirname(__FILE__), 'test_helper')

class PresenceTest < Test::Unit::TestCase

  context "A class which has included Pacecar" do
    setup do
      @class = User
    end
    context "with presence methods" do
      should "respond to a _present datetime column method" do
        assert @class.respond_to? :first_name_present
      end
      should "set the correct proxy options for a _present column method" do
        proxy_options = { :conditions => '"users".first_name is not null' }
        assert_equal proxy_options, @class.first_name_present.proxy_options
      end
      should "respond to a _missing column method" do
        assert @class.respond_to? :first_name_missing
      end
      should "set the correct proxy options for a _missing column method" do
        proxy_options = { :conditions => '"users".first_name is null' }
        assert_equal proxy_options, @class.first_name_missing.proxy_options
      end
    end
  end

end
