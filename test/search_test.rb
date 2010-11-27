require File.join(File.dirname(__FILE__), 'test_helper')

class SearchTest < Test::Unit::TestCase

  context "A class which has included Pacecar" do
    setup do
      @class = User
    end
    should "set the correct expected values for a _equals column method" do
      assert @class.respond_to?(:first_name_equals)
      expected = ["\"users\".first_name = 'test'"]
      assert_equal expected, @class.first_name_equals('test').where_values
    end
    should "set the correct expected values for a _matches column method" do
      assert @class.respond_to?(:first_name_matches)
      expected = ["\"users\".first_name like '%test%'"]
      assert_equal expected, @class.first_name_matches('test').where_values
    end
    should "set the correct expected values for a _starts_with column method" do
      assert @class.respond_to?(:first_name_starts_with)
      expected = ["\"users\".first_name like 'test%'"]
      assert_equal expected, @class.first_name_starts_with('test').where_values
    end
    should "set the correct expected values for a _ends_with column method" do
      assert @class.respond_to?(:first_name_ends_with)
      expected = ["\"users\".first_name like '%test'"]
      assert_equal expected, @class.first_name_ends_with('test').where_values
    end
    should "set the correct expected values for a search_for method" do
      assert @class.respond_to?(:search_for)
      expected = ["\"users\".first_name like '%test%' or \"users\".last_name like '%test%' or \"users\".description like '%test%'"]
      assert_equal expected, @class.search_for('test').where_values
    end
    should "set the correct expected values for a search_for method with :on option" do
      assert @class.respond_to?(:search_for)
      expected = ["\"users\".first_name like '%test%' or \"users\".description like '%test%'"]
      assert_equal expected, @class.search_for('test', :on => [:first_name, :description]).where_values
    end
    should "set the correct expected values for a search_for method with an :require option" do
      assert @class.respond_to?(:search_for)
      expected = ["\"users\".first_name like '%test%' and \"users\".last_name like '%test%' and \"users\".description like '%test%'"]
      assert_equal expected, @class.search_for('test', :require => :all).where_values
    end
  end

  context "A class which has included Pacecar but which has nothing to search" do
    setup do
      @class = Post
    end
    should "set the correct expected values for a search_for method" do
      assert @class.respond_to?(:search_for)
      expected = ['']
      assert_equal expected, @class.search_for('test').where_values
    end
  end

end
