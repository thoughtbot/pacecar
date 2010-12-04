require 'test_helper'

class RankingTest < Test::Unit::TestCase

  context "A class which has included Pacecar" do
    setup do
      @class = User
    end
    context "with association methods" do
      should "set the correct expected values on a maximum_ column method" do
        assert @class.respond_to?(:maximum_comments)
        expected_select = ["\"users\".*, count(\"users\".id) as comments_count"]
        assert_equal expected_select, @class.maximum_comments.select_values
        expected_joins = ["inner join comments on comments.user_id = \"users\".id"]
        assert_equal expected_joins, @class.maximum_comments.joins_values
        expected_group = ["comments.user_id"]
        assert_equal expected_group, @class.maximum_comments.group_values.uniq
        expected_order = ["comments_count desc"]
        assert_equal expected_order, @class.maximum_comments.order_values
      end
      should "set the correct expected values on a minimum_ column method" do
        assert @class.respond_to?(:minimum_comments)
        expected_select = ["\"users\".*, count(\"users\".id) as comments_count"]
        assert_equal expected_select, @class.minimum_comments.select_values
        expected_joins = ["inner join comments on comments.user_id = \"users\".id"]
        assert_equal expected_joins, @class.minimum_comments.joins_values
        expected_group = ["comments.user_id"]
        assert_equal expected_group, @class.minimum_comments.group_values.uniq
        expected_order = ["comments_count asc"]
        assert_equal expected_order, @class.minimum_comments.order_values
      end
    end
  end

end
