module Pacecar
  module Search
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def self.extended(base)
        base.send :define_search_scopes
      end

      protected

      def define_search_scopes
        text_and_string_column_names.each do |name|
          named_scope "#{name}_matches".to_sym, lambda { |query|
            { :conditions => ["#{name} like :query", { :query => "%#{query}%" }] }
          }
        end
      end

      def text_and_string_column_names
        column_names_for_type :text, :string
      end

    end
  end
end
