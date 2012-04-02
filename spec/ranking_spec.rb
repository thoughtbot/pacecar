require 'spec_helper'

describe 'Ranking', 'has ranking' do

  before do
    @many = create :user
    5.times { create :comment, :user => @many }
    @few = create :user
    2.times { create :comment, :user => @few }
    @none = create :user
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
    @user_one = create :user
    @user_two = create :user
    create :comment, :user => @user_one, :rating => 8
    create :comment, :user => @user_one, :rating => 6
    create :comment, :user => @user_two, :rating => 4
    create :comment, :user => @user_two, :rating => 3
    create :comment, :user => @user_two, :rating => 2
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
