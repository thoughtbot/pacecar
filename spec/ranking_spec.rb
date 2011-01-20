require 'spec_helper'

describe 'Ranking' do

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
