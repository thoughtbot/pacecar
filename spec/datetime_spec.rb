require 'spec_helper'

describe 'Datetime' do

  before do
    date = DateTime.parse '2000-01-01'
    @abe = Factory :user, :created_at => date, :rejected_at => date, :updated_at => date, :last_posted_on => date, :approved_at => date

    date = DateTime.parse '2005-05-05'
    @bob = Factory :user, :created_at => date, :rejected_at => date, :updated_at => date, :last_posted_on => date, :approved_at => date

    date = DateTime.parse '2010-10-10'
    @fox = Factory :user, :created_at => date, :rejected_at => date, :updated_at => date, :last_posted_on => date, :approved_at => date
  end

  [:created_at, :rejected_at, :updated_at, :last_posted_on, :approved_at].each do |column|
    describe "before and after methods" do
      it "should set the correct expected values for a #{column}_before method" do
        date = DateTime.parse '2003-01-01'
        User.send(:"#{column}_before", date).should == [@abe]
      end

      it "should set the correct expected values for a #{column}_after datetime column method" do
        date = DateTime.parse '2007-01-01'
        User.send(:"#{column}_after", date).should == [@fox]
      end
    end

    describe "past and future methods" do
      it "should set the correct expected values for a #{column}_in_past method without a zone default" do
        Time.zone_default = nil
        Time.zone_default.should == nil
        now = DateTime.parse '2007-01-01'
        User.stubs(:now).returns now
        User.send(:"#{column}_in_past").should == [@abe, @bob]
      end

      it "should set the correct expected values for a #{column}_in_future datetime column method without a zone default" do
        Time.zone_default = nil
        Time.zone_default.should == nil
        now = DateTime.parse '2007-01-01'
        User.stubs(:now).returns now
        User.send(:"#{column}_in_future").should == [@fox]
      end

      it "should set the correct expected values for a #{column}_in_past method given a zone_default" do
        Time.zone_default = Time.respond_to?(:find_zone) ? Time.find_zone("UTC") : Time.__send__(:get_zone, "UTC")
        now = DateTime.parse '2007-01-01'
        Time.zone_default.stubs(:now).returns now
        User.send(:"#{column}_in_past").should == [@abe, @bob]
        Time.zone_default = nil
      end

      it "should set the correct expected values for a #{column}_in_future datetime column method given a zone_default" do
        Time.zone_default = Time.respond_to?(:find_zone) ? Time.find_zone("UTC") : Time.__send__(:get_zone, "UTC")
        now = DateTime.parse '2007-01-01'
        Time.zone_default.stubs(:now).returns now
        User.send(:"#{column}_in_future").should == [@fox]
        Time.zone_default = nil
      end
    end

    describe "inside and outside methods" do
      it "should set the correct expected values for a #{column}_inside method" do
        start = DateTime.parse '2003-01-01'
        stop = DateTime.parse '2007-01-01'
        User.send(:"#{column}_inside", start, stop).should == [@bob]
      end

      it "should set the correct expected values for a #{column}_outside method" do
        start = DateTime.parse '2003-01-01'
        stop = DateTime.parse '2007-01-01'
        User.send(:"#{column}_outside", start, stop).should == [@abe, @fox]
      end
    end

    describe "year month and day methods" do
      it "should set the correct expected values for a #{column}_in_year method" do
        User.send(:"#{column}_in_year", '2000').should == [@abe]
      end

      it "should set the correct expected values for a #{column}_in_month method" do
        User.send(:"#{column}_in_month", '05').should == [@bob]
      end

      it "should set the correct expected values for a #{column}_in_day method" do
        User.send(:"#{column}_in_day", '10').should == [@fox]
      end
    end
  end

end
