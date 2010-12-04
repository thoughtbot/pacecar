module Pacecar
  module Numeric
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def self.extended(base)
        base.send :define_numeric_scopes
      end

      protected

      def define_numeric_scopes
        numeric_column_names.each do |name|
          scope "#{name}_greater_than".to_sym, lambda { |value|
            { :conditions => ["#{quoted_table_name}.\"#{name}\" > ?", value] }
          }
          scope "#{name}_greater_than_or_equal_to".to_sym, lambda { |value|
            { :conditions => ["#{quoted_table_name}.\"#{name}\" >= ?", value] }
          }
          scope "#{name}_less_than".to_sym, lambda { |value|
            { :conditions => ["#{quoted_table_name}.\"#{name}\" < ?", value] }
          }
          scope "#{name}_less_than_or_equal_to".to_sym, lambda { |value|
            { :conditions => ["#{quoted_table_name}.\"#{name}\" <= ?", value] }
          }
        end
      end

    end
  end
end
