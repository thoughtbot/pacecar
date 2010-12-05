require 'test_helper'

class BooleanTest < Test::Unit::TestCase

  context "A class which has included Pacecar" do
    setup do
      @class = User
    end
    should "set the correct expected values for a boolean column method" do
      expected =<<-SQL
      SELECT #{@class.quoted_table_name}.* FROM #{@class.quoted_table_name} WHERE (#{@class.quoted_table_name}.#{ActiveRecord::Base.connection.quote_column_name "admin"} = #{ActiveRecord::Base.connection.quoted_true})
      SQL
      assert_equal expected.strip, @class.admin.to_sql
    end
    should "set the correct expected values for a not_ boolean column method" do
      expected =<<-SQL
      SELECT #{@class.quoted_table_name}.* FROM #{@class.quoted_table_name} WHERE (#{@class.quoted_table_name}.#{ActiveRecord::Base.connection.quote_column_name "admin"} = #{ActiveRecord::Base.connection.quoted_false})
      SQL
      assert_equal expected.strip, @class.not_admin.to_sql
    end
    context "With boolean column scopes that can count" do
      setup do
        @true_mock = mock
        @false_mock = mock
        @class.expects(:admin).returns @true_mock
        @class.expects(:not_admin).returns @false_mock
      end
      should "return correct value for balance class method when true greater than false" do
        @true_mock.expects(:count).returns 5
        @false_mock.expects(:count).returns 2
        assert_equal 3, @class.admin_balance
      end
      should "return correct value for balance class method when true less than false" do
        @true_mock.expects(:count).returns 2
        @false_mock.expects(:count).returns 5
        assert_equal -3, @class.admin_balance
      end
    end
  end

end
