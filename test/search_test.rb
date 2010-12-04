require File.join(File.dirname(__FILE__), 'test_helper')

class SearchTest < Test::Unit::TestCase

  context "A class which has included Pacecar" do
    setup do
      @class = User
    end
    should "set the correct expected values for a _equals column method" do
      assert @class.respond_to?(:first_name_equals)
      expected = "SELECT \"users\".* FROM \"users\" WHERE (\"users\".\"first_name\" = 'test')"
      assert_equal expected, @class.first_name_equals('test').to_sql
    end
    should "set the correct expected values for a _equals column method with nil as value" do
      assert @class.respond_to?(:first_name_equals)
      expected = "SELECT \"users\".* FROM \"users\" WHERE (\"users\".\"first_name\" IS NULL)"
      assert_equal expected, @class.first_name_equals(nil).to_sql
    end
    should "set the correct expected values for a _matches column method" do
      assert @class.respond_to?(:first_name_matches)
      expected = "SELECT \"users\".* FROM \"users\" WHERE (\"users\".\"first_name\" LIKE '%test%')"
      assert_equal expected, @class.first_name_matches('test').to_sql
    end
    should "set the correct expected values for a _starts_with column method" do
      assert @class.respond_to?(:first_name_starts_with)
      expected = "SELECT \"users\".* FROM \"users\" WHERE (\"users\".\"first_name\" LIKE 'test%')"
      assert_equal expected, @class.first_name_starts_with('test').to_sql
    end
    should "set the correct expected values for a _ends_with column method" do
      assert @class.respond_to?(:first_name_ends_with)
      expected = "SELECT \"users\".* FROM \"users\" WHERE (\"users\".\"first_name\" LIKE '%test')"
      assert_equal expected, @class.first_name_ends_with('test').to_sql
    end
    should "set the correct expected values for a search_for method" do
      assert @class.respond_to?(:search_for)
      expected = "SELECT \"users\".* FROM \"users\" WHERE (\"users\".\"first_name\" LIKE '%test%' OR \"users\".\"last_name\" LIKE '%test%' OR \"users\".\"description\" LIKE '%test%')"
      assert_equal expected, @class.search_for('test').to_sql
    end
    should "set the correct expected values for a search_for method with :on option" do
      assert @class.respond_to?(:search_for)
      expected = "SELECT \"users\".* FROM \"users\" WHERE (\"users\".\"first_name\" LIKE '%test%' OR \"users\".\"description\" LIKE '%test%')"
      assert_equal expected, @class.search_for('test', :on => [:first_name, :description]).to_sql
    end
    should "set the correct expected values for a search_for method with an :require option" do
      assert @class.respond_to?(:search_for)
      expected = "SELECT \"users\".* FROM \"users\" WHERE (\"users\".\"first_name\" LIKE '%test%' AND \"users\".\"last_name\" LIKE '%test%' AND \"users\".\"description\" LIKE '%test%')"
      assert_equal expected, @class.search_for('test', :require => :all).to_sql
    end
  end

  context "A class which has included Pacecar but which has nothing to search" do
    setup do
      @class = Post
    end
    should "set the correct expected values for a search_for method" do
      assert @class.respond_to?(:search_for)
      expected = "SELECT \"posts\".* FROM \"posts\""
      assert_equal expected, @class.search_for('test').to_sql
    end
  end

end
