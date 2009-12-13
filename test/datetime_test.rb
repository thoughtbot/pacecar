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
            @time = 5.days.ago
          end
          should "set the correct proxy options for a #{column}_before method" do
            assert @class.respond_to?(:"#{column}_before")
            proxy_options = { :conditions => ["\"users\".#{column} <= ?", @time] }
            assert_equal proxy_options, @class.send(:"#{column}_before", @time).proxy_options
          end
          should "set the correct proxy options for a after_ datetime column method" do
            assert @class.respond_to?(:"#{column}_before")
            proxy_options = { :conditions => ["\"users\".#{column} >= ?", @time] }
            assert_equal proxy_options, @class.send(:"#{column}_after", @time).proxy_options
          end
        end

        context "with in_past and in_future methods" do
          setup do
            @now = Time.now
            Time.stubs(:now).returns @now
          end
          should "set the correct proxy options for a #{column}_in_past method" do
            assert @class.respond_to?(:"#{column}_in_past")
            proxy_options = { :conditions => ["\"users\".#{column} <= ?", @now] }
            assert_equal proxy_options, @class.send(:"#{column}_in_past", @time).proxy_options
          end
          should "set the correct proxy options for a #{column}_in_future datetime column method" do
            assert @class.respond_to?(:"#{column}_in_future")
            proxy_options = { :conditions => ["\"users\".#{column} >= ?", @now] }
            assert_equal proxy_options, @class.send(:"#{column}_in_future", @time).proxy_options
          end
        end

        context "with _inside and _outside methods" do
          setup do
            @start = 3.days.ago
            @stop = 2.days.ago
          end
          should "set the correct proxy options for a #{column}_inside method" do
            assert @class.respond_to?(:"#{column}_inside")
            proxy_options = { :conditions => ["\"users\".#{column} >= ? and \"users\".#{column} <= ?", @start, @stop] }
            assert_equal proxy_options, @class.send(:"#{column}_inside", @start, @stop).proxy_options
          end
          should "set the correct proxy options for a #{column}_outside method" do
            assert @class.respond_to?(:"#{column}_outside")
            proxy_options = { :conditions => ["\"users\".#{column} <= ? and \"users\".#{column} >= ?", @start, @stop] }
            assert_equal proxy_options, @class.send(:"#{column}_outside", @start, @stop).proxy_options 
          end
        end

        context "with year month and day methods" do
          setup do
            @year = '2000'
            @month = '01'
            @day = '01'
          end
          should "set the correct proxy options for a #{column}_in_year method" do
            assert @class.respond_to?(:"#{column}_in_year")
            proxy_options = { :conditions => ["year(\"users\".#{column}) = ?", @year] }
            assert_equal proxy_options, @class.send(:"#{column}_in_year", @year).proxy_options
          end
          should "set the correct proxy options for a #{column}_in_month method" do
            assert @class.respond_to?(:"#{column}_in_month")
            proxy_options = { :conditions => ["month(\"users\".#{column}) = ?", @month] }
            assert_equal proxy_options, @class.send(:"#{column}_in_month", @month).proxy_options
          end
          should "set the correct proxy options for a #{column}_in_day method" do
            assert @class.respond_to?(:"#{column}_in_day")
            proxy_options = { :conditions => ["day(\"users\".#{column}) = ?", @day] }
            assert_equal proxy_options, @class.send(:"#{column}_in_day", @day).proxy_options
          end
        end

      end
    end
  end

end
