module Pacecar

  module Boolean

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods

      def self.extended(base)
        base.send :define_boolean_scopes
      end

      protected

      def define_boolean_scopes
        boolean_columns.each do |column|
          named_scope column.to_sym, :conditions => { column.to_sym => true }
          named_scope "not_#{column}".to_sym, :conditions => { column.to_sym => false }
        end
      end

      def boolean_columns
        columns_of_type :boolean
      end

    end

  end

end
