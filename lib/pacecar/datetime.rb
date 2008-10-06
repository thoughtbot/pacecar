module Pacecar

  module Datetime

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods

      def self.extended(base)
        base.define_datetime_scopes
      end

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
        end
      end

      protected

      def datetime_columns
        columns_of_type :datetime
      end

    end

  end

end
