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

      protected

      def define_ranking_scope(association, name, direction)
        scope "#{name}_#{association}",
        :select => "#{quoted_table_name}.*, count(#{reflections[association].quoted_table_name}.#{connection.quote_column_name reflections[association].primary_key_name}) as #{association}_count",
        :joins => "inner join #{association} on #{association}.#{reflections[association].primary_key_name} = #{quoted_table_name}.#{connection.quote_column_name primary_key}",
        :group => safe_column_names.collect { |column_name| "#{quoted_table_name}.#{connection.quote_column_name(column_name)}" }.join(', '),
        :order => "#{association}_count #{direction}"
      end

    end
  end
end
