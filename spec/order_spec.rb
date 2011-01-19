require 'spec_helper'

describe 'Order' do

  before do
    @first = Factory :user, :first_name => 'Abe'
    @last  = Factory :user, :first_name => 'Zed'
  end

  it "should set the correct expected values for a by_ column method with no args" do
    User.by_first_name.should == [@first, @last]
  end

  it "should set the correct expected values for a by_ column method with asc args" do
    User.by_first_name(:asc).should == [@first, @last]
  end

  it "should set the correct expected values for a by_ column method with desc args" do
    User.by_first_name(:desc).should == [@last, @first]
  end

end
