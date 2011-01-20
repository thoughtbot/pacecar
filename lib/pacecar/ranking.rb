module Pacecar
  module Ranking
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods

      def has_ranking(association)
        define_ranking_scope association, :maximum, :desc
        define_ranking_scope association, :minimum, :asc
      end

      def has_calculated_records(*names)
        opts = names.extract_options!
        names.each do |association_name|
          *columns = opts[:on] || []
          columns.flatten.each do |column|
            define_calculated_scope association_name, column, :average, :avg
            define_calculated_scope association_name, column, :total, :sum
            define_calculated_scope association_name, column, :count, :count
          end
        end
      end

      protected

      def define_ranking_scope(association, direction_name, direction)
        scope "#{direction_name}_#{association}", {
          :select => "#{quoted_table_name}.*, count(#{reflections[association].quoted_table_name}.#{connection.quote_column_name reflections[association].primary_key_name}) as #{association}_count",
          :order => "#{association}_count #{direction}"
        }.merge(association_group_and_join(association))
      end

      def define_calculated_scope(association_name, column, function_name, function_method)
        { 'highest' => 'desc', 'lowest' => 'asc' }.each do |direction_name, direction|
          scope "by_#{association_name}_#{direction_name}_#{column}_#{function_name}".to_sym, {
            :select => "#{quoted_table_name}.*, #{function_method}(#{connection.quote_table_name(association_name)}.#{connection.quote_column_name column}) as #{association_name}_#{column}_#{function_name}",
            :order => "#{association_name}_#{column}_#{function_name} #{direction}"
          }.merge(association_group_and_join(association_name))
        end
      end

      def association_group_and_join(association_name)
        {
          :joins => "inner join #{connection.quote_table_name(association_name)} on #{connection.quote_table_name(association_name)}.#{connection.quote_column_name reflections[association_name].primary_key_name} = #{quoted_table_name}.#{connection.quote_column_name primary_key}",
          :group => safe_column_names.collect { |column_name| "#{quoted_table_name}.#{connection.quote_column_name(column_name)}" }.join(', ')
        }
      end

    end
  end
end
