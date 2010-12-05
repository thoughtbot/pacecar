require 'test_helper'

class PolymorphTest < Test::Unit::TestCase

  context "A class which has included Pacecar" do
    setup do
      @class = Post
    end
    context "with polymorph methods" do
      should "set the correct expected values on a _for column method with Class" do
        expected =<<-SQL
        SELECT #{@class.quoted_table_name}.* FROM #{@class.quoted_table_name} WHERE (#{@class.quoted_table_name}.#{ActiveRecord::Base.connection.quote_column_name "owner_type"} = 'User')
        SQL
        assert_equal expected.strip, @class.for_owner_type(User).to_sql
      end
      should "set the correct expected values on a _for column method with String" do
        expected =<<-SQL
        SELECT #{@class.quoted_table_name}.* FROM #{@class.quoted_table_name} WHERE (#{@class.quoted_table_name}.#{ActiveRecord::Base.connection.quote_column_name "owner_type"} = 'User')
        SQL
        assert_equal expected.strip, @class.for_owner_type('User').to_sql
      end
    end
  end

end
