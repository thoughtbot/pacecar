require 'active_support/concern'

module Pacecar
  module State
    extend ActiveSupport::Concern

    module ClassMethods

      def has_state(*names)
        opts = names.extract_options!
        names.each do |name|
          constant = opts[:with] || const_get(name.to_s.pluralize.upcase)
          constant.each do |state|
            define_state_scopes(name, state)
            define_state_queries(name, state)
          end
          define_where_scopes(name)
        end
      end

      def define_state_scopes(name, state)
        scope "#{name}_#{state.downcase}", -> {
          where(arel_table[name].eq state)
        }
        scope "#{name}_not_#{state.downcase}", -> {
          where(arel_table[name].not_eq state)
        }
      end

      def define_state_queries(name, state)
        self.class_eval %Q{
          def #{name}_#{state.downcase}?
            #{name} == '#{state}'
          end
          def #{name}_not_#{state.downcase}?
            #{name} != '#{state}'
          end
        }
      end

      def define_where_scopes(name)
        scope "#{name}", ->(state) {
          where(arel_table[name].eq state)
        }
        scope "#{name}_not", ->(state) {
          where(arel_table[name].not_eq state)
        }
      end

    end
  end
end
