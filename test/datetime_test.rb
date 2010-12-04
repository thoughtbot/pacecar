require 'test_helper'

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
            expected =<<-SQL
            SELECT "users".* FROM "users" WHERE ("users"."#{column}" <= '#{@time.to_s(:db)}')
            SQL
            assert_equal expected.strip, @class.send(:"#{column}_before", @time).to_sql
          end
          should "set the correct expected values for a after_ datetime column method" do
            expected =<<-SQL
            SELECT "users".* FROM "users" WHERE ("users"."#{column}" >= '#{@time.to_s(:db)}')
            SQL
            assert_equal expected.strip, @class.send(:"#{column}_after", @time).to_sql
          end
        end

        context "with in_past and in_future methods" do
          setup do
            assert_nil Time.zone_default
            @now = Time.now.utc.to_datetime
            @class.stubs(:now).returns @now
          end
          should "set the correct expected values for a #{column}_in_past method" do
            expected =<<-SQL
            SELECT "users".* FROM "users" WHERE ("users"."#{column}" <= '#{@now.to_s(:db)}')
            SQL
            assert_equal expected.strip, @class.send(:"#{column}_in_past").to_sql
          end
          should "set the correct expected values for a #{column}_in_future datetime column method" do
            expected =<<-SQL
            SELECT "users".* FROM "users" WHERE ("users"."#{column}" >= '#{@now.to_s(:db)}')
            SQL
            assert_equal expected.strip, @class.send(:"#{column}_in_future").to_sql
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
            expected =<<-SQL
            SELECT "users".* FROM "users" WHERE ("users"."#{column}" <= '#{@now.to_s(:db)}')
            SQL
            assert_equal expected.strip, @class.send(:"#{column}_in_past", @time).to_sql
          end
          should "set the correct expected values for a #{column}_in_future datetime column method" do
            expected =<<-SQL
            SELECT "users".* FROM "users" WHERE ("users"."#{column}" >= '#{@now.to_s(:db)}')
            SQL
            assert_equal expected.strip, @class.send(:"#{column}_in_future", @time).to_sql
          end
        end

        context "with _inside and _outside methods" do
          setup do
            @start = 3.days.ago.to_datetime
            @stop = 2.days.ago.to_datetime
          end
          should "set the correct expected values for a #{column}_inside method" do
            expected =<<-SQL
            SELECT "users".* FROM "users" WHERE ("users"."#{column}" >= '#{@start.to_s(:db)}' and "users"."#{column}" <= '#{@stop.to_s(:db)}')
            SQL
            assert_equal expected.strip, @class.send(:"#{column}_inside", @start, @stop).to_sql
          end
          should "set the correct expected values for a #{column}_outside method" do
            expected =<<-SQL
            SELECT "users".* FROM "users" WHERE ("users"."#{column}" <= '#{@start.to_s(:db)}' and "users"."#{column}" >= '#{@stop.to_s(:db)}')
            SQL
            assert_equal expected.strip, @class.send(:"#{column}_outside", @start, @stop).to_sql
          end
        end

        context "with year month and day methods" do
          setup do
            @year = '2000'
            @month = '01'
            @day = '01'
          end
          should "set the correct expected values for a #{column}_in_year method" do
            expected =<<-SQL
            SELECT "users".* FROM "users" WHERE (year("users"."#{column}") = '#{@year}')
            SQL
            assert_equal expected.strip, @class.send(:"#{column}_in_year", @year).to_sql
          end
          should "set the correct expected values for a #{column}_in_month method" do
            expected =<<-SQL
            SELECT "users".* FROM "users" WHERE (month("users"."#{column}") = '#{@month}')
            SQL
            assert_equal expected.strip, @class.send(:"#{column}_in_month", @month).to_sql
          end
          should "set the correct expected values for a #{column}_in_day method" do
            expected =<<-SQL
            SELECT "users".* FROM "users" WHERE (day("users"."#{column}") = '#{@day}')
            SQL
            assert_equal expected.strip, @class.send(:"#{column}_in_day", @day).to_sql
          end
        end

      end
    end
  end

end
