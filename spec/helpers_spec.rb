require 'spec_helper'

describe 'Helpers' do

  describe "A class without a db table" do
    it "should return an empty array when asked about #safe_columns" do
      Article.safe_columns.should == []
    end

    it "should survive an include of Pacecar" do
      lambda { Article.send :include, Pacecar }.should_not raise_error
    end
  end

  describe "A class with a db table" do
    it "should  should return columns for #safe_column_names" do
      Comment.safe_column_names.should == ['id', 'user_id', 'description', 'created_at', 'updated_at']
    end
  end

  describe "A class with many column types" do
    it "should return boolean columns for #boolean_column_names" do
      User.boolean_column_names.should == ['admin']
    end

    it "should return non boolean columns for #non_boolean_column_names" do
      User.non_boolean_column_names.should == ['id', 'approved_at', 'rejected_at', 'last_posted_on', 'first_name', 'last_name', 'description', 'age', 'rating', 'created_at', 'updated_at']
    end

    it "should  return datetime columns for #datetime_column_names" do
      User.datetime_column_names.should == ['approved_at', 'rejected_at', 'last_posted_on', 'created_at', 'updated_at']
    end

    it "should  return text and string columns for #text_and_string_column_names" do
      User.text_and_string_column_names.should == ['first_name', 'last_name', 'description']
    end

    it "should  return numeric columns for #numeric_column_names" do
      User.numeric_column_names.should == ['id', 'age', 'rating']
    end
  end

  describe "A class with a state column should" do
    it "should return all non state text and string columns for #non_state_text_and_string_column_names" do
      Post.non_state_text_and_string_columns.should == ['title', 'body']
    end
  end

end
