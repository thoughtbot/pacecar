require File.join(File.dirname(__FILE__), 'test_helper')

class StateTest < Test::Unit::TestCase

  context "A class which has included Pacecar" do
    setup do
      @class = Post
    end
    should "set the correct proxy options for a column_state _state method" do
      assert @class.respond_to?(:publication_state_draft)
      proxy_options = { :conditions => ['"posts".publication_state = ?', 'Draft'] }
      assert_equal proxy_options, @class.publication_state_draft.proxy_options
    end
    should "set the correct proxy options for a column_not_state _state method" do
      assert @class.respond_to?(:publication_state_not_draft)
      proxy_options = { :conditions => ['"posts".publication_state <> ?', 'Draft'] }
      assert_equal proxy_options, @class.publication_state_not_draft.proxy_options
    end
    should "set the correct proxy options for a column_state _type method" do
      assert @class.respond_to?(:post_type_postmodern)
      proxy_options = { :conditions => ['"posts".post_type = ?', 'PostModern'] }
      assert_equal proxy_options, @class.post_type_postmodern.proxy_options
    end
    should "set the correct proxy options for a column_not_state _type method" do
      assert @class.respond_to?(:post_type_not_postmodern)
      proxy_options = { :conditions => ['"posts".post_type <> ?', 'PostModern'] }
      assert_equal proxy_options, @class.post_type_not_postmodern.proxy_options
    end
    should "set the correct proxy options for a column_state method" do
      assert @class.respond_to?(:post_type)
      proxy_options = { :conditions => ['"posts".post_type = ?', 'PostModern'] }
      assert_equal proxy_options, @class.post_type('PostModern').proxy_options
    end
    should "set the correct proxy options for a column_state_not method" do
      assert @class.respond_to?(:post_type_not)
      proxy_options = { :conditions => ['"posts".post_type <> ?', 'PostModern'] }
      assert_equal proxy_options, @class.post_type_not('PostModern').proxy_options
    end
  end

  context "A Post" do
    setup { @post = Post.new }
    Post::PUBLICATION_STATES.each do |state|
      context "with a #{state} state value" do
        should "have a query method" do
          assert @post.respond_to?("publication_state_#{state.downcase}?")
        end
        should "have a non query method" do
          assert @post.respond_to?("publication_state_not_#{state.downcase}?")
        end
        context "when in that state" do
          setup { @post.publication_state = state }
          should "respond true to query method" do
            assert @post.send("publication_state_#{state.downcase}?")
          end
          should "respond false to not query method" do
            assert ! @post.send("publication_state_not_#{state.downcase}?")
          end
        end
        context "when not in that state" do
          setup { @post.publication_state = 'Invalid' }
          should "respond false to query method" do
            assert ! @post.send("publication_state_#{state.downcase}?")
          end
          should "respond true to not query method" do
            assert @post.send("publication_state_not_#{state.downcase}?")
          end
        end
      end
    end
  end

end
