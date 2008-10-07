module Pacecar
  module Polymorph
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def self.extended(base)
        base.send :define_polymorph_scopes
      end

      protected

      def define_polymorph_scopes
        polymorph_column_names.each do |name|
          named_scope "for_#{name}_type".to_sym, lambda { |type|
            { :conditions => ["#{quoted_table_name}.#{name}_type = ?", type.to_s] }
          }
        end
      end

      def polymorph_column_names
        reflections.select { |k,v| v.options[:polymorphic] }.map(&:first).map(&:to_s)
      end

    end
  end
end
