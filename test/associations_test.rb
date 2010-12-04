require 'test_helper'

class AssociationsTest < Test::Unit::TestCase

  context "A class which has included Pacecar" do
    setup do
      @class = User
    end
    context "with recent_records methods" do
      setup do
        @time = 2.days.ago.to_datetime
      end
      should "set the correct options for a recent methods for one association" do
        assert @class.respond_to?(:recent_comments_since)
        expected = ["((select count(*) from \"comments\" where \"comments\".user_id = \"users\".id and \"comments\".created_at > '#{@time.to_s(:db)}') > 0)"]
        assert_equal expected, @class.recent_comments_since(@time).where_values
      end
      should "set the correct options for a recent methods combining associations with or" do
        assert @class.respond_to?(:recent_articles_or_comments_since)
        expected = ["((select count(*) from \"articles\" where \"articles\".user_id = \"users\".id and \"articles\".created_at > '#{@time.to_s(:db)}') > 0) or ((select count(*) from \"comments\" where \"comments\".user_id = \"users\".id and \"comments\".created_at > '#{@time.to_s(:db)}') > 0)"]
        assert_equal expected, @class.recent_articles_or_comments_since(@time).where_values
      end
      should "set the correct options for a recent methods combining associations with and" do
        assert @class.respond_to?(:recent_articles_and_comments_since)
        expected = ["((select count(*) from \"articles\" where \"articles\".user_id = \"users\".id and \"articles\".created_at > '#{@time.to_s(:db)}') > 0) and ((select count(*) from \"comments\" where \"comments\".user_id = \"users\".id and \"comments\".created_at > '#{@time.to_s(:db)}') > 0)"]
        assert_equal expected, @class.recent_articles_and_comments_since(@time).where_values
      end
    end
  end

end
