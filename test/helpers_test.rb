require 'test_helper'

class HelpersTest < Test::Unit::TestCase

  context "A class without a db table" do
    setup do
      @class = Article
    end
    should "return an empty array when asked about #safe_columns" do
      columns = @class.send :safe_columns
      assert_equal [], columns
    end
    should "survive an include of Pacecar" do
      assert_nothing_raised do
        @class.send :include, Pacecar
      end
    end
  end

  context "A class with a db table" do
    setup do
      @class = Comment
    end
    should "return columns for #safe_column_names" do
      column_names = @class.send :safe_column_names
      assert_equal ['id', 'user_id', 'description', 'created_at', 'updated_at'], column_names
    end
  end

  context "A class with many column types" do
    setup do
      @class = User
    end
    should "return boolean columns for #boolean_column_names" do
      column_names = @class.send :boolean_column_names
      assert_equal ['admin'], column_names
    end
    should "return non boolean columns for #non_boolean_column_names" do
      column_names = @class.send :non_boolean_column_names
      assert_equal ['id', 'approved_at', 'rejected_at', 'last_posted_on', 'first_name', 'last_name', 'description', 'age', 'rating', 'created_at', 'updated_at'], column_names
    end
    should "return datetime columns for #datetime_column_names" do
      column_names = @class.send :datetime_column_names
      assert_equal ['approved_at', 'rejected_at', 'last_posted_on', 'created_at', 'updated_at'], column_names
    end
    should "return text and string columns for #text_and_string_column_names" do
      column_names = @class.send :text_and_string_column_names
      assert_equal ['first_name', 'last_name', 'description'], column_names
    end
    should "return numeric columns for #numeric_column_names" do
      column_names = @class.send :numeric_column_names
      assert_equal ['id', 'age', 'rating'], column_names
    end
  end

  context "A class with a state column" do
    setup do
      @class = Post
    end
    should "return all non state text and string columns for #non_state_text_and_string_column_names" do
      column_names = @class.send :non_state_text_and_string_columns
      assert_equal ['title', 'body'], column_names
    end
  end

end
