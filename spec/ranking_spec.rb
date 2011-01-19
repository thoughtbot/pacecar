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
    User.maximum_comments.should == [@many, @few]
  end

  it "should set the correct expected values on a minimum_ column method" do
    User.minimum_comments.should == [@few, @many]
  end

end
