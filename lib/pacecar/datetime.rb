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
        datetime_columns.each do |column|
          named_scope column.to_sym, :conditions => "#{column} is not null"
          named_scope "not_#{column}".to_sym, :conditions => "#{column} is null"
          named_scope "#{column}_before".to_sym, lambda { |time|
            { :conditions => ["#{column} < ?", time] }
          }
          named_scope "#{column}_after".to_sym, lambda { |time|
            { :conditions => ["#{column} > ?", time] }
          }
          named_scope "#{column}_in_past", lambda {
            { :conditions => ["#{column} < ?", Time.now] }
          }
          named_scope "#{column}_in_future", lambda {
            { :conditions => ["#{column} > ?", Time.now] }
          }
        end
      end

      def datetime_columns
        columns_of_type :datetime
      end

    end

  end

end
