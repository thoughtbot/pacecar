require 'test_helper'

class SearchTest < ActiveSupport::TestCase

  setup do
    @abe      = Factory :user, :first_name => 'Abe',    :last_name => 'Anderson', :description => 'Apple'
    @bob      = Factory :user, :first_name => 'Bob',    :last_name => 'Babson',   :description => 'Banana'
    @cindy    = Factory :user, :first_name => 'Cindy',  :last_name => 'Clarkson', :description => 'Cookie'
    @dave     = Factory :user, :first_name => 'Dave'
    @ed       = Factory :user, :last_name => 'Dave'
    @frank    = Factory :user, :description => 'Dave'
    @george   = Factory :user, :first_name => 'Dave',   :last_name => 'Dave',     :description => 'Dave'

    @null     = Factory :user, :first_name => nil,      :last_name => nil,        :description => nil
  end

  test "set the correct expected values for a _equals column method" do
    assert_equal [@abe], User.first_name_equals('Abe')
  end

  test "set the correct expected values for a _equals column method with an Array as value" do
    assert_equal [@abe, @bob], User.first_name_equals(['Abe', 'Bob'])
  end

  test "set the correct expected values for a _equals column method with nil as value" do
    assert_equal [@ed, @frank, @null], User.first_name_equals(nil)
  end

  test "set the correct expected values for a _matches column method" do
    assert_equal [@cindy], User.first_name_matches('ind')
    assert_equal [@cindy], User.first_name_matches('IND')
  end

  test "set the correct expected values for a _starts_with column method" do
    assert_equal [@abe], User.first_name_starts_with('Ab')
    assert_equal [@abe], User.first_name_starts_with('aB')
  end

  test "set the correct expected values for a _ends_with column method" do
    assert_equal [@bob], User.first_name_ends_with('ob')
    assert_equal [@bob], User.first_name_ends_with('Ob')
  end

  test "set the correct expected values for a search_for method" do
    assert_equal [@dave, @ed, @frank, @george], User.search_for('Dave')
    assert_equal [@dave, @ed, @frank, @george], User.search_for('dave')
  end

  test "set the correct expected values for a search_for method with :on option" do
    assert_equal [@dave, @frank, @george], User.search_for('Dave', :on => [:first_name, :description])
    assert_equal [@dave, @frank, @george], User.search_for('dave', :on => [:first_name, :description])
  end

  test "set the correct expected values for a search_for method with an :require option" do
    assert_equal [@george], User.search_for('Dave', :require => :all)
    assert_equal [@george], User.search_for('dave', :require => :all)
  end

  test "set the correct expected values for a search_for method on a class with no columns" do
    assert_equal [], Mammal.search_for('test')
  end

end
