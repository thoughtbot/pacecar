require 'test_helper'

class RankingTest < Test::Unit::TestCase

  context "A class which has included Pacecar" do
    setup do
      @class = User
    end
    context "with association methods" do
      should "set the correct expected values on a maximum_ column method" do
        expected =<<-SQL
        SELECT #{@class.quoted_table_name}.*, count(#{@class.quoted_table_name}.#{ActiveRecord::Base.connection.quote_column_name @class.primary_key}) as comments_count FROM #{@class.quoted_table_name} inner join comments on comments.user_id = #{@class.quoted_table_name}.#{ActiveRecord::Base.connection.quote_column_name @class.primary_key} GROUP BY comments.user_id ORDER BY comments_count desc
        SQL
        assert_equal expected.strip, @class.maximum_comments.to_sql
      end
      should "set the correct expected values on a minimum_ column method" do
        expected =<<-SQL
        SELECT #{@class.quoted_table_name}.*, count(#{@class.quoted_table_name}.#{ActiveRecord::Base.connection.quote_column_name @class.primary_key}) as comments_count FROM #{@class.quoted_table_name} inner join comments on comments.user_id = #{@class.quoted_table_name}.#{ActiveRecord::Base.connection.quote_column_name @class.primary_key} GROUP BY comments.user_id ORDER BY comments_count asc
        SQL
        assert_equal expected.strip, @class.minimum_comments.to_sql
      end
    end
  end

end
