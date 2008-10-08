module Pacecar
  module Helpers

    mattr_accessor :options
    self.options = {
      :state_pattern => /_(type|state)$/i
    }

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods

      def column_names
        columns.collect(&:name)
      end

      def column_names_for_type(*types)
        columns.select { |column| types.include? column.type }.collect(&:name)
      end

      def column_names_without_type(*types)
        columns.select { |column| ! types.include? column.type }.collect(&:name)
      end

      def boolean_column_names
        column_names_for_type :boolean
      end

      def datetime_column_names
        column_names_for_type :datetime
      end

      def text_and_string_column_names
        column_names_for_type :text, :string
      end

      def non_state_text_and_string_columns
        text_and_string_column_names.reject { |name| name =~ Pacecar::Helpers.options[:state_pattern] }
      end

    end
  end
end
