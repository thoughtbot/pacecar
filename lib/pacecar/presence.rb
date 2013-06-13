require 'active_support/concern'

module Pacecar
  module Presence
    extend ActiveSupport::Concern

    included do
      define_presence_scopes
    end

    module ClassMethods

      def define_presence_scopes
        non_boolean_column_names.each do |name|
          scope "#{name}_present", -> { where(arel_table[name].not_eq nil) }
          scope "#{name}_missing", -> { where(arel_table[name].eq nil) }
        end
      end

    end
  end
end
