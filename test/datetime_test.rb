require 'test_helper'

class DatetimeTest < ActiveSupport::TestCase

  setup do
    date = DateTime.parse '2000-01-01'
    @abe = Factory :user, :created_at => date, :rejected_at => date, :updated_at => date, :last_posted_on => date, :approved_at => date

    date = DateTime.parse '2005-05-05'
    @bob = Factory :user, :created_at => date, :rejected_at => date, :updated_at => date, :last_posted_on => date, :approved_at => date

    date = DateTime.parse '2010-10-10'
    @fox = Factory :user, :created_at => date, :rejected_at => date, :updated_at => date, :last_posted_on => date, :approved_at => date
  end

  [:created_at, :rejected_at, :updated_at, :last_posted_on, :approved_at].each do |column|
    test "set the correct expected values for a #{column}_before method" do
      date = DateTime.parse '2003-01-01'
      assert_equal [@abe], User.send(:"#{column}_before", date)
    end

    test "set the correct expected values for a #{column}_after datetime column method" do
      date = DateTime.parse '2007-01-01'
      assert_equal [@fox], User.send(:"#{column}_after", date)
    end

    test "set the correct expected values for a #{column}_in_past method without a zone default" do
      assert_nil Time.zone_default
      now = DateTime.parse '2007-01-01'
      User.stubs(:now).returns now
      assert_equal [@abe, @bob], User.send(:"#{column}_in_past")
    end

    test "set the correct expected values for a #{column}_in_future datetime column method without a zone default" do
      assert_nil Time.zone_default
      now = DateTime.parse '2007-01-01'
      User.stubs(:now).returns now
      assert_equal [@fox], User.send(:"#{column}_in_future")
    end

    test "set the correct expected values for a #{column}_in_past method given a zone_default" do
      Time.zone_default = Time.__send__(:get_zone, "UTC")
      now = DateTime.parse '2007-01-01'
      Time.zone_default.stubs(:now).returns now
      assert_equal [@abe, @bob], User.send(:"#{column}_in_past")
      Time.zone_default = nil
    end

    test "set the correct expected values for a #{column}_in_future datetime column method given a zone_default" do
      Time.zone_default = Time.__send__(:get_zone, "UTC")
      now = DateTime.parse '2007-01-01'
      Time.zone_default.stubs(:now).returns now
      assert_equal [@fox], User.send(:"#{column}_in_future")
      Time.zone_default = nil
    end

    test "set the correct expected values for a #{column}_inside method" do
      start = DateTime.parse '2003-01-01'
      stop = DateTime.parse '2007-01-01'
      assert_equal [@bob], User.send(:"#{column}_inside", start, stop)
    end
    test "set the correct expected values for a #{column}_outside method" do
      start = DateTime.parse '2003-01-01'
      stop = DateTime.parse '2007-01-01'
      assert_equal [@abe, @fox], User.send(:"#{column}_outside", start, stop)
    end

    test "set the correct expected values for a #{column}_in_year method" do
      assert_equal [@abe], User.send(:"#{column}_in_year", '2000')
    end
    test "set the correct expected values for a #{column}_in_month method" do
      assert_equal [@bob], User.send(:"#{column}_in_month", '05')
    end
    test "set the correct expected values for a #{column}_in_day method" do
      assert_equal [@fox], User.send(:"#{column}_in_day", '10')
    end

  end

end
