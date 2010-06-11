require File.join(File.dirname(__FILE__), 'test_helper')

class DatetimeTest < Test::Unit::TestCase

  context "A class which has included Pacecar" do
    setup do
      @class = User
    end
    context "for each date and datetime column" do
      [:created_at, :rejected_at, :updated_at, :last_posted_on, :approved_at].each do |column|
        context "with before and after methods for #{column}" do
          setup do
            @time = 5.days.ago.to_datetime
          end
          should "set the correct expected values for a #{column}_before method" do
            assert @class.respond_to?(:"#{column}_before")
            expected = ["\"users\".#{column} <= '#{@time.to_s(:db)}'"]
            assert_equal expected, @class.send(:"#{column}_before", @time).where_values
          end
          should "set the correct expected values for a after_ datetime column method" do
            assert @class.respond_to?(:"#{column}_before")
            expected = ["\"users\".#{column} >= '#{@time.to_s(:db)}'"]
            assert_equal expected, @class.send(:"#{column}_after", @time).where_values
          end
        end

        context "with in_past and in_future methods" do
          setup do
            assert_nil Time.zone_default
            @now = Time.now.utc.to_datetime
            @class.stubs(:now).returns @now
          end
          should "set the correct expected values for a #{column}_in_past method" do
            assert @class.respond_to?(:"#{column}_in_past")
            expected = ["\"users\".#{column} <= '#{@now.to_s(:db)}'"]
            assert_equal expected, @class.send(:"#{column}_in_past").where_values
          end
          should "set the correct expected values for a #{column}_in_future datetime column method" do
            assert @class.respond_to?(:"#{column}_in_future")
            expected = ["\"users\".#{column} >= '#{@now.to_s(:db)}'"]
            assert_equal expected, @class.send(:"#{column}_in_future").where_values
          end
        end

        context "with in_past and in_future methods given a zone_default" do
          setup do
            Time.zone_default = Time.__send__(:get_zone, "UTC")
            @now = Time.zone_default.now.to_datetime
            Time.zone_default.stubs(:now).returns @now
          end
          teardown do
            Time.zone_default = nil
          end
          should "set the correct expected values for a #{column}_in_past method" do
            assert @class.respond_to?(:"#{column}_in_past")
            expected = ["\"users\".#{column} <= '#{@now.to_s(:db)}'"]
            assert_equal expected, @class.send(:"#{column}_in_past", @time).where_values
          end
          should "set the correct expected values for a #{column}_in_future datetime column method" do
            assert @class.respond_to?(:"#{column}_in_future")
            expected = ["\"users\".#{column} >= '#{@now.to_s(:db)}'"]
            assert_equal expected, @class.send(:"#{column}_in_future", @time).where_values
          end
        end

        context "with _inside and _outside methods" do
          setup do
            @start = 3.days.ago.to_datetime
            @stop = 2.days.ago.to_datetime
          end
          should "set the correct expected values for a #{column}_inside method" do
            assert @class.respond_to?(:"#{column}_inside")
            expected = ["\"users\".#{column} >= '#{@start.to_s(:db)}' and \"users\".#{column} <= '#{@stop.to_s(:db)}'"]
            assert_equal expected, @class.send(:"#{column}_inside", @start, @stop).where_values
          end
          should "set the correct expected values for a #{column}_outside method" do
            assert @class.respond_to?(:"#{column}_outside")
            expected = ["\"users\".#{column} <= '#{@start.to_s(:db)}' and \"users\".#{column} >= '#{@stop.to_s(:db)}'"]
            assert_equal expected, @class.send(:"#{column}_outside", @start, @stop).where_values
          end
        end

        context "with year month and day methods" do
          setup do
            @year = '2000'
            @month = '01'
            @day = '01'
          end
          should "set the correct expected values for a #{column}_in_year method" do
            assert @class.respond_to?(:"#{column}_in_year")
            expected = ["year(\"users\".#{column}) = '#{@year}'"]
            assert_equal expected, @class.send(:"#{column}_in_year", @year).where_values
          end
          should "set the correct expected values for a #{column}_in_month method" do
            assert @class.respond_to?(:"#{column}_in_month")
            expected = ["month(\"users\".#{column}) = '#{@month}'"]
            assert_equal expected, @class.send(:"#{column}_in_month", @month).where_values
          end
          should "set the correct expected values for a #{column}_in_day method" do
            assert @class.respond_to?(:"#{column}_in_day")
            expected = ["day(\"users\".#{column}) = '#{@day}'"]
            assert_equal expected, @class.send(:"#{column}_in_day", @day).where_values
          end
        end

      end
    end
  end

end
