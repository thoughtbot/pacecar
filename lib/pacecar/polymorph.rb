module Pacecar
  module Polymorph
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods

      def has_polymorph(name)
        scope "for_#{name}_type".to_sym, lambda { |type|
          polymorph_type = "#{name}_type"
          { :conditions => ["#{quoted_table_name}.#{connection.quote_column_name polymorph_type} = ?", type.to_s] }
        }
      end

    end
  end
end
