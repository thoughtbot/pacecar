module Pacecar
  module Presence
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def self.extended(base)
        base.send :define_presence_scopes
      end

      protected

      def define_presence_scopes
        non_boolean_column_names.each do |name|
          scope "#{name}_present".to_sym, :conditions => "#{quoted_table_name}.\"#{name}\" IS NOT NULL"
          scope "#{name}_missing".to_sym, :conditions => "#{quoted_table_name}.\"#{name}\" IS NULL"
        end
      end

    end
  end
end
