module Pacecar
  module Datetime
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def self.extended(base)
        base.send :define_datetime_scopes
      end

      protected

      def define_datetime_scopes
        datetime_column_names.each do |name|
          define_before_after_scopes(name)
          define_past_future_scopes(name)
          define_inside_outside_scopes(name)
          define_in_date_scopes(name)
        end
        define_duration_scopes
      end

      def define_before_after_scopes(name)
        named_scope "#{name}_before".to_sym, lambda { |time| { :conditions => ["#{name} < ?", time] } }
        named_scope "#{name}_after".to_sym, lambda { |time| { :conditions => ["#{name} > ?", time] } }
      end

      def define_past_future_scopes(name)
        named_scope "#{name}_in_past", lambda { { :conditions => ["#{name} < ?", Time.now] } }
        named_scope "#{name}_in_future", lambda { { :conditions => ["#{name} > ?", Time.now] } }
      end

      def define_inside_outside_scopes(name)
        named_scope "#{name}_inside".to_sym, lambda { |start, stop| { :conditions => ["#{name} > ? and #{name} < ?", start, stop] } }
        named_scope "#{name}_outside".to_sym, lambda { |start, stop| { :conditions => ["#{name} < ? and #{name} > ?", start, stop] } }
      end

      def define_in_date_scopes(name)
        named_scope "#{name}_in_year".to_sym, lambda { |year| { :conditions => ["year(#{name}) = ?", year] } }
        named_scope "#{name}_in_month".to_sym, lambda { |month| { :conditions => ["month(#{name}) = ?", month] } }
        named_scope "#{name}_in_day".to_sym, lambda { |day| { :conditions => ["day(#{name}) = ?", day] } }
      end

      def define_duration_scopes
        named_scope :duration_between, lambda { |start, stop| { :select => "datediff(#{start}, #{stop}) as duration" } }
        named_scope :with_duration_of, lambda { |duration| { :conditions => ['duration = ?', duration] } }
        named_scope :with_duration_over, lambda { |duration| { :conditions => ['duration >= ?', duration] } }
        named_scope :with_duration_under, lambda { |duration| { :conditions => ['duration <= ?', duration] } }
      end

      def datetime_column_names
        column_names_for_type :datetime
      end

    end
  end
end
