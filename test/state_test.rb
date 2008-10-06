require File.join(File.dirname(__FILE__), 'test_helper')

class StateTest < Test::Unit::TestCase

  context "A class which has included Pacecar" do
    setup do
      @class = Post
    end
    should "respond to column_state method" do
      assert @class.respond_to? :publication_state_draft
    end
    should "set correct proxy options for column_state method" do
      proxy_options = { :conditions => ['publication_state = ?', 'Draft'] }
      assert_equal proxy_options, @class.publication_state_draft.proxy_options
    end
  end

end
