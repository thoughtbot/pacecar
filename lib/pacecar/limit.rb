module Pacecar
  module Limit
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def self.extended(base)
        base.send :define_limit_scopes
      end

      protected

      def define_limit_scopes
        named_scope :limited, lambda { |*args|
          { :limit => args.flatten.first || (defined?(per_page) ? per_page : 10) }
        }
      end

    end
  end
end
