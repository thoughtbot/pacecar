require File.join(File.dirname(__FILE__), 'test_helper')

class RankingTest < Test::Unit::TestCase

  context "A class which has included Pacecar" do
    setup do
      @class = User
    end
    context "with association methods" do
      should "set the correct proxy options on a maximum_ column method" do
        assert @class.respond_to? :maximum_comments
        proxy_options = {
          :select => '"users".*, count("users".id) as comments_count',
          :joins => 'inner join comments on comments.user_id = "users".id',
          :group => 'comments.user_id',
          :order => 'comments_count desc'
        }
        assert_equal proxy_options, @class.maximum_comments.proxy_options
      end
      should "set the correct proxy options on a minimum_ column method" do
        assert @class.respond_to? :minimum_comments
        proxy_options = {
          :select => '"users".*, count("users".id) as comments_count',
          :joins => 'inner join comments on comments.user_id = "users".id',
          :group => 'comments.user_id',
          :order => 'comments_count asc'
        }
        assert_equal proxy_options, @class.minimum_comments.proxy_options
      end
    end
  end

end
