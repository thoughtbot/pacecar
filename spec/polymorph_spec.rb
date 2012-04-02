require 'spec_helper'

describe 'Polymorph' do

  before do
    @owned_by_user = create :post, :owner_type => 'User'
    @owned_by_mammal = create :post, :owner_type => 'Mammal'
  end

  it "should set the correct expected values on a _for column method with Class" do
    Post.for_owner_type(User).should == [@owned_by_user]
  end

  it "should set the correct expected values on a _for column method with String" do
    Post.for_owner_type('User').should == [@owned_by_user]
  end

end
