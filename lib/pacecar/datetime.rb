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
        end
      end

      def define_before_after_scopes(name)
        named_scope "#{name}_before".to_sym,  lambda { |time| { :conditions => ["#{name} < ?", time] } }
        named_scope "#{name}_after".to_sym,   lambda { |time| { :conditions => ["#{name} > ?", time] } }
      end

      def define_past_future_scopes(name)
        named_scope "#{name}_in_past",    lambda { { :conditions => ["#{name} < ?", Time.now] } }
        named_scope "#{name}_in_future",  lambda { { :conditions => ["#{name} > ?", Time.now] } }
      end

      def datetime_column_names
        column_names_for_type :datetime
      end

    end
  end
end
