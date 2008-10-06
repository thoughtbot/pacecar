require File.join(File.dirname(__FILE__), 'test_helper')

class PolymorphTest < Test::Unit::TestCase

  context "A class which has included Pacecar" do
    setup do
      @class = Post
    end
    context "with polymorph methods" do
      should "respond to for_ polymorph type method" do
        assert @class.respond_to? :for_owner_type
      end
      should "set correct proxy options on _for column method with Class" do
        proxy_options = { :conditions => { :owner_type => 'User' } }
        assert_equal proxy_options, @class.for_owner_type(User).proxy_options
      end
      should "set correct proxy options on _for column method with String" do
        proxy_options = { :conditions => { :owner_type => 'User' } }
        assert_equal proxy_options, @class.for_owner_type('User').proxy_options
      end
    end
  end

end
