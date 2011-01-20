require 'spec_helper'

describe 'Ranking', 'has ranking' do

  before do
    @many = Factory :user
    5.times { Factory :comment, :user => @many }
    @few = Factory :user
    2.times { Factory :comment, :user => @few }
    @none = Factory :user
  end

  it "should set the correct expected values on a maximum_ column method" do
    output = User.maximum_comments
    output.should == [@many, @few]
    output.first.comments_count.to_i.should == 5
    output.last.comments_count.to_i.should == 2
  end

  it "should set the correct expected values on a minimum_ column method" do
    output = User.minimum_comments
    output.should == [@few, @many]
    output.first.comments_count.to_i.should == 2
    output.last.comments_count.to_i.should == 5
  end

end

describe 'Ranking', 'has calculated records' do
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
