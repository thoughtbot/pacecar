require 'spec_helper'

describe 'Presence' do

  before do
    @not_null = Factory :user, :first_name => 'Fake'
    @null = Factory :user, :first_name => nil
  end

  it "should set the correct expected values for a _present column method" do
    User.first_name_present.should == [@not_null]
  end

  it "should set the correct expected values for a _missing column method" do
    User.first_name_missing.should == [@null]
  end

  it "should not setup methods for boolean columns" do
    lambda { User.admin_missing }.should raise_error(NoMethodError)
    lambda { User.admin_present }.should raise_error(NoMethodError)
  end

end
