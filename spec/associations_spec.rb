require 'spec_helper'

describe 'Associations', 'has recent records' do

  before do
    @comment_user = Factory :user
    @post_user = Factory :user
    @both_user = Factory :user
    Factory :comment, :user => @comment_user, :created_at => 10.days.ago
    Factory :comment, :user => @comment_user, :created_at => 3.days.ago
    Factory :post, :owner => @post_user, :created_at => 10.days.ago
    Factory :post, :owner => @post_user, :created_at => 3.days.ago

    Factory :comment, :user => @both_user, :created_at => 10.days.ago
    Factory :comment, :user => @both_user, :created_at => 3.days.ago
    Factory :post, :owner => @both_user, :created_at => 10.days.ago
    Factory :post, :owner => @both_user, :created_at => 3.days.ago
  end

  it "should set the correct options for a recent methods for one association" do
    User.recent_comments_since(5.days.ago).should == [@comment_user, @both_user]
  end

  it "should set the correct options for a recent methods combining associations with or" do
    User.recent_posts_or_comments_since(5.days.ago).should == [@comment_user, @post_user, @both_user]
  end

  it "should set the correct options for a recent methods combining associations with and" do
    User.recent_posts_and_comments_since(5.days.ago).should == [@both_user]
  end

end
