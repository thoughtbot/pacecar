require 'spec_helper'

describe 'Duration' do

  before do
    @same_user = create :user, :created_at => 15.days.ago.midnight, :updated_at => 15.days.ago.midnight
    @updated_user = create :user, :created_at => 15.days.ago.midnight, :updated_at => 1.days.ago.midnight
  end

  it "should set the correct expected values for a with_duration_of datetime column method" do
    User.with_duration_of(14, :created_at, :updated_at).should == [@updated_user]
  end

  it "should set the correct expected values for a with_duration_over datetime column method" do
    User.with_duration_over(10, :created_at, :updated_at).should == [@updated_user]
  end

  it "should set the correct expected values for a with_duration_under datetime column method" do
    User.with_duration_under(10, :created_at, :updated_at).should == [@same_user]
  end

end
