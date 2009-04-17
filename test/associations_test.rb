require File.join(File.dirname(__FILE__), 'test_helper')

class AssociationsTest < Test::Unit::TestCase

  context "A class which has included Pacecar" do
    setup do
      @class = User
    end
    context "with recent_records methods" do
      setup do
        @time = 2.days.ago
      end
      should "set the correct options for a recent methods for one association" do
        assert @class.respond_to?(:recent_comments_since)
        proxy_options = { :conditions => ['((select count(*) from "comments" where "comments".user_id = "users".id and "comments".created_at > :since_time) > 0)', { :since_time => @time }] }
        assert_equal proxy_options, @class.recent_comments_since(@time).proxy_options
      end
      should "set the correct options for a recent methods combining associations with or" do
        assert @class.respond_to?(:recent_articles_or_comments_since)
        proxy_options = { :conditions => ['((select count(*) from "articles" where "articles".user_id = "users".id and "articles".created_at > :since_time) > 0) or ((select count(*) from "comments" where "comments".user_id = "users".id and "comments".created_at > :since_time) > 0)', { :since_time => @time }] }
        assert_equal proxy_options, @class.recent_articles_or_comments_since(@time).proxy_options
      end
      should "set the correct options for a recent methods combining associations with and" do
        assert @class.respond_to?(:recent_articles_and_comments_since)
        proxy_options = { :conditions => ['((select count(*) from "articles" where "articles".user_id = "users".id and "articles".created_at > :since_time) > 0) and ((select count(*) from "comments" where "comments".user_id = "users".id and "comments".created_at > :since_time) > 0)', { :since_time => @time }] }
        assert_equal proxy_options, @class.recent_articles_and_comments_since(@time).proxy_options
      end
    end
  end

end
