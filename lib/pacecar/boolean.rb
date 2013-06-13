require 'active_support/concern'

module Pacecar
  module Boolean
    extend ActiveSupport::Concern

    included do
      define_boolean_scopes
    end

    module ClassMethods

      def define_boolean_scopes
        boolean_column_names.each do |name|
          scope name, -> { where(name => true) }
          scope "not_#{name}", -> { where(name => false) }
        end
      end

    end
  end
end
