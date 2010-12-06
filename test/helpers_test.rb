require 'test_helper'

class HelpersTest < ActiveSupport::TestCase

  test "A class without a db table should return an empty array when asked about #safe_columns" do
    columns = Article.send :safe_columns
    assert_equal [], columns
  end

  test "A class without a db table should survive an include of Pacecar" do
    assert_nothing_raised do
      Article.send :include, Pacecar
    end
  end

  test "A class with a db table should return columns for #safe_column_names" do
    column_names = Comment.safe_column_names
    assert_equal ['id', 'user_id', 'description', 'created_at', 'updated_at'], column_names
  end

  test "A class with many column types should return boolean columns for #boolean_column_names" do
    column_names = User.boolean_column_names
    assert_equal ['admin'], column_names
  end

  test "A class with many column types should return non boolean columns for #non_boolean_column_names" do
    column_names = User.non_boolean_column_names
    assert_equal ['id', 'approved_at', 'rejected_at', 'last_posted_on', 'first_name', 'last_name', 'description', 'age', 'rating', 'created_at', 'updated_at'], column_names
  end

  test "A class with many column types should return datetime columns for #datetime_column_names" do
    column_names = User.datetime_column_names
    assert_equal ['approved_at', 'rejected_at', 'last_posted_on', 'created_at', 'updated_at'], column_names
  end

  test "A class with many column types should return text and string columns for #text_and_string_column_names" do
    column_names = User.text_and_string_column_names
    assert_equal ['first_name', 'last_name', 'description'], column_names
  end

  test "A class with many column types should return numeric columns for #numeric_column_names" do
    column_names = User.numeric_column_names
    assert_equal ['id', 'age', 'rating'], column_names
  end

  test "A class with a state column should return all non state text and string columns for #non_state_text_and_string_column_names" do
    column_names = Post.non_state_text_and_string_columns
    assert_equal ['title', 'body'], column_names
  end

end
