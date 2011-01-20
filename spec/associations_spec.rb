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

describe 'Associations', 'has calculated records' do
  before do
    @user_one = Factory :user
    @user_two = Factory :user
    Factory :comment, :user => @user_one, :rating => 8
    Factory :comment, :user => @user_one, :rating => 6
    Factory :comment, :user => @user_two, :rating => 4
    Factory :comment, :user => @user_two, :rating => 3
    Factory :comment, :user => @user_two, :rating => 2
  end
  it "should order records based on association column highest average" do
    output = User.by_comments_highest_rating_average
    output.should == [@user_one, @user_two]
    output.first.comments_rating_average.to_i.should == 7
    output.last.comments_rating_average.to_i.should == 3
  end
  it "should order records based on association column lowest average" do
    output = User.by_comments_lowest_rating_average
    output.should == [@user_two, @user_one]
    output.first.comments_rating_average.to_i.should == 3
    output.last.comments_rating_average.to_i.should == 7
  end
  it "should order records based on association column highest total" do
    output = User.by_comments_highest_rating_total
    output.should == [@user_one, @user_two]
    output.first.comments_rating_total.to_i.should == 14
    output.last.comments_rating_total.to_i.should == 9
  end
  it "should order records based on association column lowest total" do
    output = User.by_comments_lowest_rating_total
    output.should == [@user_two, @user_one]
    output.first.comments_rating_total.to_i.should == 9
    output.last.comments_rating_total.to_i.should == 14
  end
end
