require 'test_helper'

class LimitTest < Test::Unit::TestCase

  context "A class which has included Pacecar" do
    setup do
      @class = User
    end
    context "with order methods" do
      should "set the correct expected values for a by_ column method" do
        expected =<<-SQL
        SELECT #{@class.quoted_table_name}.* FROM #{@class.quoted_table_name} LIMIT 10
        SQL
        assert_equal expected.strip, @class.limited.to_sql
      end
      should "set the correct expected values for a by_ column method when sent args" do
        expected =<<-SQL
        SELECT #{@class.quoted_table_name}.* FROM #{@class.quoted_table_name} LIMIT 20
        SQL
        assert_equal expected.strip, @class.limited(20).to_sql
      end
      should "set the correct expected values for a by_ column method when per_page defined" do
        @class.expects(:per_page).returns 30
        expected =<<-SQL
        SELECT #{@class.quoted_table_name}.* FROM #{@class.quoted_table_name} LIMIT 30
        SQL
        assert_equal expected.strip, @class.limited.to_sql
      end
    end
  end

end
