require File.join(File.dirname(__FILE__), 'test_helper')

class SearchTest < Test::Unit::TestCase

  context "A class which has included Pacecar" do
    setup do
      @class = User
    end
    should "respond to _matches column method" do
      assert @class.respond_to? :first_name_matches
    end
    should "set correct proxy options for _matches column method" do
      proxy_options = { :conditions => ["first_name like :query", { :query => "%test%" }] }
      assert_equal proxy_options, @class.first_name_matches('test').proxy_options
    end
    should "set correct proxy options for _starts_with column method" do
      proxy_options = { :conditions => ["first_name like :query", { :query => "test%" }] }
      assert_equal proxy_options, @class.first_name_starts_with('test').proxy_options
    end
    should "set correct proxy options for _ends_with column method" do
      proxy_options = { :conditions => ["first_name like :query", { :query => "%test" }] }
      assert_equal proxy_options, @class.first_name_ends_with('test').proxy_options
    end
    should "set correct proxy options for search_for method" do
      proxy_options = { :conditions => ["first_name like :query or last_name like :query", { :query => "%test%" }] }
      assert_equal proxy_options, @class.search_for('test').proxy_options
    end
    should "set correct proxy options for search_for method when class has nothing to search" do
      @class = Post
      proxy_options = { :conditions => ["", { :query => "%test%" }] }
      assert_equal proxy_options, @class.search_for('test').proxy_options
    end
  end

end
