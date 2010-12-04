require 'test_helper'

class OrderTest < Test::Unit::TestCase

  context "A class which has included Pacecar" do
    setup do
      @class = User
    end
    context "with order methods" do
      should "set the correct expected values for a by_ column method with no args" do
        expected =<<-SQL
        SELECT "users".* FROM "users" ORDER BY "users"."first_name" asc
        SQL
        assert_equal expected.strip, @class.by_first_name.to_sql
      end
      should "set the correct expected values for a by_ column method with asc args" do
        expected =<<-SQL
        SELECT "users".* FROM "users" ORDER BY "users"."first_name" asc
        SQL
        assert_equal expected.strip, @class.by_first_name(:asc).to_sql
      end
      should "set the correct expected values for a by_ column method with desc args" do
        expected =<<-SQL
        SELECT "users".* FROM "users" ORDER BY "users"."first_name" desc
        SQL
        assert_equal expected.strip, @class.by_first_name(:desc).to_sql
      end
    end
  end

end
