module Pacecar
  module Search
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def self.extended(base)
        base.send :define_search_scopes
        base.send :define_basic_search_scope
      end

      protected

      def define_search_scopes
        text_and_string_column_names.each do |name|
          named_scope "#{name}_matches".to_sym, lambda { |query|
            { :conditions => ["#{name} like :query", { :query => "%#{query}%" }] }
          }
        end
      end

      def define_basic_search_scope
        matcher = non_state_text_and_string_columns.collect { |column| "#{column} like :query" }.join(" or ")
        named_scope :search_for, lambda { |query|
          { :conditions => [matcher, { :query => "%#{query}%" } ] }
        }
      end

      def text_and_string_column_names
        column_names_for_type :text, :string
      end

      def non_state_text_and_string_columns
        text_and_string_column_names.reject { |name| name =~ /_(type|state)/ }
      end

    end
  end
end
