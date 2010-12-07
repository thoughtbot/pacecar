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
        :select => "distinct #{quoted_table_name}.*, (select count(*) from #{reflections[association].quoted_table_name} inner_#{association} where inner_#{association}.#{reflections[association].primary_key_name} = #{quoted_table_name}.#{connection.quote_column_name primary_key}) as #{association}_count",
        :joins => "inner join #{association} on #{association}.#{reflections[association].primary_key_name} = #{quoted_table_name}.#{connection.quote_column_name primary_key}",
        :order => "#{association}_count #{direction}"
      end

    end
  end
end
