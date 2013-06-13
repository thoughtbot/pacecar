require 'active_support/concern'

module Pacecar
  module Search
    extend ActiveSupport::Concern

    included do
      define_search_scopes
    end

    module ClassMethods

      def define_search_scopes
        safe_column_names.each do |name|
          scope "#{name}_equals", ->(query) {
            where(name => query)
          }
        end
      end

    end
  end
end
