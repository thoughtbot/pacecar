require 'spec_helper'

describe 'Numeric' do

  before do
    @young = create :user, :age => 11, :rating => 10.0
    @legal = create :user, :age => 21, :rating => 7.5
    @older = create :user, :age => 31, :rating => 5.0
  end

  it "should set the correct expected values for a _greater_than column method for an integer column" do
    User.age_greater_than(21).should == [@older]
  end

  it "should set the correct expected values for a _greater_than_or_equal_to column method for an integer column" do
    User.age_greater_than_or_equal_to(21).should == [@legal, @older]
  end

  it "should set the correct expected values for a _less_than column method for an integer column" do
    User.age_less_than(21).should == [@young]
  end

  it "should set the correct expected values for a _less_than_or_equal_to column method for an integer column" do
    User.age_less_than_or_equal_to(21).should == [@young, @legal]
  end

  it "should set the correct expected values for a _greater_than column method for a float column" do
    User.rating_greater_than(7.5).should == [@young]
  end

  it "should set the correct expected values for a _greater_than_or_equal_to column method for a float column" do
    User.rating_greater_than_or_equal_to(7.5).should == [@young, @legal]
  end

  it "should set the correct expected values for a _less_than column method for a float column" do
    User.rating_less_than(7.5).should == [@older]
  end

  it "should set the correct expected values for a _less_than_or_equal_to column method for a float column" do
    User.rating_less_than_or_equal_to(7.5).should == [@legal, @older]
  end

end
