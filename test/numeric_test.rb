require 'test_helper'

class NumericTest < Test::Unit::TestCase

  context "A class which has included Pacecar" do
    setup do
      @class = User
    end
    context "for an integer column" do
      should "set the correct expected values for a _greater_than column method" do
        assert @class.respond_to?(:age_greater_than)
        expected = "SELECT \"users\".* FROM \"users\" WHERE (\"users\".\"age\" > 21)"
        assert_equal expected, @class.age_greater_than(21).to_sql
      end
      should "set the correct expected values for a _greater_than_or_equal_to column method" do
        assert @class.respond_to?(:age_greater_than_or_equal_to)
        expected = "SELECT \"users\".* FROM \"users\" WHERE (\"users\".\"age\" >= 21)"
        assert_equal expected, @class.age_greater_than_or_equal_to(21).to_sql
      end
      should "set the correct expected values for a _less_than column method" do
        assert @class.respond_to?(:age_less_than)
        expected = "SELECT \"users\".* FROM \"users\" WHERE (\"users\".\"age\" < 21)"
        assert_equal expected, @class.age_less_than(21).to_sql
      end
      should "set the correct expected values for a _less_than_or_equal_to column method" do
        assert @class.respond_to?(:age_less_than_or_equal_to)
        expected = "SELECT \"users\".* FROM \"users\" WHERE (\"users\".\"age\" <= 21)"
        assert_equal expected, @class.age_less_than_or_equal_to(21).to_sql
      end
    end

    context "for a float column" do
      should "set the correct expected values for a _greater_than column method" do
        assert @class.respond_to?(:rating_greater_than)
        expected = "SELECT \"users\".* FROM \"users\" WHERE (\"users\".\"rating\" > 21)"
        assert_equal expected, @class.rating_greater_than(21).to_sql
      end
      should "set the correct expected values for a _greater_than_or_equal_to column method" do
        assert @class.respond_to?(:rating_greater_than_or_equal_to)
        expected = "SELECT \"users\".* FROM \"users\" WHERE (\"users\".\"rating\" >= 21)"
        assert_equal expected, @class.rating_greater_than_or_equal_to(21).to_sql
      end
      should "set the correct expected values for a _less_than column method" do
        assert @class.respond_to?(:rating_less_than)
        expected = "SELECT \"users\".* FROM \"users\" WHERE (\"users\".\"rating\" < 21)"
        assert_equal expected, @class.rating_less_than(21).to_sql
      end
      should "set the correct expected values for a _less_than_or_equal_to column method" do
        assert @class.respond_to?(:rating_less_than_or_equal_to)
        expected = "SELECT \"users\".* FROM \"users\" WHERE (\"users\".\"rating\" <= 21)"
        assert_equal expected, @class.rating_less_than_or_equal_to(21).to_sql
      end
    end
  end

end
