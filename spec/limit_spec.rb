require 'spec_helper'

describe 'Limit' do

  before do
    50.times { create :user }
  end

  it "should set the correct expected values for a by_ column method" do
    User.count.should == 50
    User.limited.all.size.should == 10
  end

  it "should set the correct expected values for a by_ column method when sent args" do
    User.count.should == 50
    User.limited(20).all.size.should == 20
  end

  it "should set the correct expected values for a by_ column method when per_page defined" do
    User.expects(:per_page).returns 30
    User.count.should == 50
    User.limited.all.size.should == 30
  end

end
