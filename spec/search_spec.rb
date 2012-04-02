require 'spec_helper'

describe 'Search' do

  before do
    @abe      = create :user, :first_name => 'Abe',    :last_name => 'Anderson', :description => 'Apple'
    @bob      = create :user, :first_name => 'Bob',    :last_name => 'Babson',   :description => 'Banana'
    @cindy    = create :user, :first_name => 'Cindy',  :last_name => 'Clarkson', :description => 'Cookie'
    @dave     = create :user, :first_name => 'Dave'
    @ed       = create :user, :last_name => 'Dave'
    @frank    = create :user, :description => 'Dave'
    @george   = create :user, :first_name => 'Dave',   :last_name => 'Dave',     :description => 'Dave'

    @null     = create :user, :first_name => nil,      :last_name => nil,        :description => nil
  end

  it "should set the correct expected values for a _equals column method" do
    User.first_name_equals('Abe').should == [@abe]
  end

  it "should set the correct expected values for a _equals column method with an Array as value" do
    User.first_name_equals(['Abe', 'Bob']).should == [@abe, @bob]
  end

  it "should set the correct expected values for a _equals column method with nil as value" do
    User.first_name_equals(nil).should == [@ed, @frank, @null]
  end

  it "should set the correct expected values for a _matches column method" do
    User.first_name_matches('ind').should == [@cindy]
    User.first_name_matches('IND').should == [@cindy]
  end

  it "should set the correct expected values for a _starts_with column method" do
    User.first_name_starts_with('Ab').should == [@abe]
    User.first_name_starts_with('aB').should == [@abe]
  end

  it "should set the correct expected values for a _ends_with column method" do
    User.first_name_ends_with('ob').should == [@bob]
    User.first_name_ends_with('Ob').should == [@bob]
  end

  it "should set the correct expected values for a search_for method" do
    User.search_for('Dave').should == [@dave, @ed, @frank, @george]
    User.search_for('dave').should == [@dave, @ed, @frank, @george]
  end

  it "should set the correct expected values for a search_for method with :on option" do
    User.search_for('Dave', :on => [:first_name, :description]).should == [@dave, @frank, @george]
    User.search_for('dave', :on => [:first_name, :description]).should == [@dave, @frank, @george]
  end

  it "should set the correct expected values for a search_for method with an :require option" do
    User.search_for('Dave', :require => :all).should == [@george]
    User.search_for('dave', :require => :all).should == [@george]
  end

  it "should set the correct expected values for a search_for method on a class with no columns" do
    Mammal.search_for('test').should == []
  end

end
