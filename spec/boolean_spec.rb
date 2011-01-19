require 'spec_helper'

describe 'Boolean' do

  before do
    @one = Factory :user, :admin => true
    @two = Factory :user, :admin => true
    @three = Factory :user, :admin => true
    @four = Factory :user, :admin => false
    @five = Factory :user, :admin => false
  end

  it "should set the correct expected values for a boolean column method" do
    User.admin.should == [@one, @two, @three]
  end

  it "should set the correct expected values for a not_ boolean column method" do
    User.not_admin.should == [@four, @five]
  end

  it "should return correct value for balance class method when true greater than false" do
    User.admin_balance.should == 1
  end

  it "should return correct value for balance class method when true less than false" do
    3.times { Factory :user, :admin => false }
    User.admin_balance.should == -2
  end

end
