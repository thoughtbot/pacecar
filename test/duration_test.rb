require File.join(File.dirname(__FILE__), 'test_helper')

class DurationTest < Test::Unit::TestCase

  context "A class which has included Pacecar" do
    setup do
      @class = User
    end
    context "with duration methods" do
      setup do
        @days = 14
      end
      should "set the correct expected values for a with_duration_of datetime column method" do
        assert @class.respond_to?(:with_duration_of)
        expected = ["datediff(\"users\".created_at, \"users\".updated_at) = #{@days}"]
        assert_equal expected, @class.with_duration_of(@days, :created_at, :updated_at).where_values
      end
      should "set the correct expected values for a with_duration_over datetime column method" do
        assert @class.respond_to?(:with_duration_of)
        expected = ["datediff(\"users\".created_at, \"users\".updated_at) > #{@days}"]
        assert_equal expected, @class.with_duration_over(@days, :created_at, :updated_at).where_values
      end
      should "set the correct expected values for a with_duration_under datetime column method" do
        assert @class.respond_to?(:with_duration_under)
        expected = ["datediff(\"users\".created_at, \"users\".updated_at) < #{@days}"]
        assert_equal expected, @class.with_duration_under(@days, :created_at, :updated_at).where_values
      end
    end
  end

end
