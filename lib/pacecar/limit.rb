require 'active_support/concern'

module Pacecar
  module Limit
    extend ActiveSupport::Concern

    included do
      define_limit_scopes
    end

    module ClassMethods

      def define_limit_scopes
        scope :limited, ->(*args) {
          value = args.flatten.first || (defined?(per_page) ? per_page : Pacecar::Helpers.options[:default_limit])
          limit(value)
        }
      end

    end
  end
end
