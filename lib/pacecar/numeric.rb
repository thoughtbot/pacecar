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
          { :greater_than => '>', :less_than => '<' }.each do |method_name, symbol|
            scope "#{name}_#{method_name}".to_sym, lambda { |value|
              { :conditions => ["#{quoted_table_name}.\"#{name}\" #{symbol} ?", value] }
            }
            scope "#{name}_#{method_name}_or_equal_to".to_sym, lambda { |value|
              { :conditions => ["#{quoted_table_name}.\"#{name}\" #{symbol}= ?", value] }
            }
          end
        end
      end

    end
  end
end
