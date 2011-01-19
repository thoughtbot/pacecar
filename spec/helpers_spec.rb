require 'spec_helper'

describe 'Helpers' do

  it "should A class without a db table should return an empty array when asked about #safe_columns" do
    columns = Article.send :safe_columns
    columns.should == []
  end

  it "should A class without a db table should survive an include of Pacecar" do
    lambda { Article.send :include, Pacecar }.should_not raise_error
  end

  it "should A class with a db table should return columns for #safe_column_names" do
    column_names = Comment.safe_column_names
    column_names.should == ['id', 'user_id', 'description', 'created_at', 'updated_at']
  end

  it "should A class with many column types should return boolean columns for #boolean_column_names" do
    column_names = User.boolean_column_names
    column_names.should == ['admin']
  end

  it "should A class with many column types should return non boolean columns for #non_boolean_column_names" do
    column_names = User.non_boolean_column_names
    column_names.should == ['id', 'approved_at', 'rejected_at', 'last_posted_on', 'first_name', 'last_name', 'description', 'age', 'rating', 'created_at', 'updated_at']
  end

  it "should A class with many column types should return datetime columns for #datetime_column_names" do
    column_names = User.datetime_column_names
    column_names.should == ['approved_at', 'rejected_at', 'last_posted_on', 'created_at', 'updated_at']
  end

  it "should A class with many column types should return text and string columns for #text_and_string_column_names" do
    column_names = User.text_and_string_column_names
    column_names.should == ['first_name', 'last_name', 'description']
  end

  it "should A class with many column types should return numeric columns for #numeric_column_names" do
    column_names = User.numeric_column_names
    column_names.should == ['id', 'age', 'rating']
  end

  it "should A class with a state column should return all non state text and string columns for #non_state_text_and_string_column_names" do
    column_names = Post.non_state_text_and_string_columns
    column_names.should == ['title', 'body']
  end

end
