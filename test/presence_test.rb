require 'test_helper'

class PresenceTest < Test::Unit::TestCase

  context "A class which has included Pacecar" do
    setup do
      @class = User
    end
    context "with presence methods" do
      should "set the correct expected values for a _present column method" do
        expected =<<-SQL
        SELECT #{@class.quoted_table_name}.* FROM #{@class.quoted_table_name} WHERE (#{@class.quoted_table_name}.#{ActiveRecord::Base.connection.quote_column_name "first_name"} IS NOT NULL)
        SQL
        assert_equal expected.strip, @class.first_name_present.to_sql
      end
      should "set the correct expected values for a _missing column method" do
        expected =<<-SQL
        SELECT #{@class.quoted_table_name}.* FROM #{@class.quoted_table_name} WHERE (#{@class.quoted_table_name}.#{ActiveRecord::Base.connection.quote_column_name "first_name"} IS NULL)
        SQL
        assert_equal expected.strip, @class.first_name_missing.to_sql
      end
      should "not setup methods for boolean columns" do
        assert_raise(NoMethodError) { @class.admin_missing }
        assert_raise(NoMethodError) { @class.admin_present }
      end
    end
  end

end
