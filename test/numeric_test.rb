require 'test_helper'

class NumericTest < Test::Unit::TestCase

  context "A class which has included Pacecar" do
    setup do
      @class = User
    end
    context "for an integer column" do
      should "set the correct expected values for a _greater_than column method" do
        expected =<<-SQL
        SELECT "users".* FROM "users" WHERE ("users"."age" > 21)
        SQL
        assert_equal expected.strip, @class.age_greater_than(21).to_sql
      end
      should "set the correct expected values for a _greater_than_or_equal_to column method" do
        expected =<<-SQL
        SELECT "users".* FROM "users" WHERE ("users"."age" >= 21)
        SQL
        assert_equal expected.strip, @class.age_greater_than_or_equal_to(21).to_sql
      end
      should "set the correct expected values for a _less_than column method" do
        expected =<<-SQL
        SELECT "users".* FROM "users" WHERE ("users"."age" < 21)
        SQL
        assert_equal expected.strip, @class.age_less_than(21).to_sql
      end
      should "set the correct expected values for a _less_than_or_equal_to column method" do
        expected =<<-SQL
        SELECT "users".* FROM "users" WHERE ("users"."age" <= 21)
        SQL
        assert_equal expected.strip, @class.age_less_than_or_equal_to(21).to_sql
      end
    end

    context "for a float column" do
      should "set the correct expected values for a _greater_than column method" do
        expected =<<-SQL
        SELECT "users".* FROM "users" WHERE ("users"."rating" > 21)
        SQL
        assert_equal expected.strip, @class.rating_greater_than(21).to_sql
      end
      should "set the correct expected values for a _greater_than_or_equal_to column method" do
        expected =<<-SQL
        SELECT "users".* FROM "users" WHERE ("users"."rating" >= 21)
        SQL
        assert_equal expected.strip, @class.rating_greater_than_or_equal_to(21).to_sql
      end
      should "set the correct expected values for a _less_than column method" do
        expected =<<-SQL
        SELECT "users".* FROM "users" WHERE ("users"."rating" < 21)
        SQL
        assert_equal expected.strip, @class.rating_less_than(21).to_sql
      end
      should "set the correct expected values for a _less_than_or_equal_to column method" do
        expected =<<-SQL
        SELECT "users".* FROM "users" WHERE ("users"."rating" <= 21)
        SQL
        assert_equal expected.strip, @class.rating_less_than_or_equal_to(21).to_sql
      end
    end
  end

end
