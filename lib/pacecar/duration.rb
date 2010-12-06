module Pacecar
  module Duration
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def self.extended(base)
        base.send :define_duration_scopes
      end

      protected

      def define_duration_scopes
        case connection.adapter_name
        when 'MySQL', 'Mysql2'
          scope :with_duration_of, lambda { |duration, start, stop|
            { :conditions => ["abs(datediff(#{quoted_table_name}.#{connection.quote_column_name start}, #{quoted_table_name}.#{connection.quote_column_name stop})) = ?", duration] }
          }
          scope :with_duration_over, lambda { |duration, start, stop|
            { :conditions => ["abs(datediff(#{quoted_table_name}.#{connection.quote_column_name start}, #{quoted_table_name}.#{connection.quote_column_name stop})) > ?", duration] }
          }
          scope :with_duration_under, lambda { |duration, start, stop|
            { :conditions => ["abs(datediff(#{quoted_table_name}.#{connection.quote_column_name start}, #{quoted_table_name}.#{connection.quote_column_name stop})) < ?", duration] }
          }
        when 'PostgreSQL'
          scope :with_duration_of, lambda { |duration, start, stop|
            { :conditions => ["age(#{quoted_table_name}.#{connection.quote_column_name stop}, #{quoted_table_name}.#{connection.quote_column_name start}) = '? days'", duration] }
          }
          scope :with_duration_over, lambda { |duration, start, stop|
            { :conditions => ["age(#{quoted_table_name}.#{connection.quote_column_name stop}, #{quoted_table_name}.#{connection.quote_column_name start}) > interval '? days'", duration] }
          }
          scope :with_duration_under, lambda { |duration, start, stop|
            { :conditions => ["age(#{quoted_table_name}.#{connection.quote_column_name stop}, #{quoted_table_name}.#{connection.quote_column_name start}) < interval '? days'", duration] }
          }
        when 'SQLite'
          scope :with_duration_of, lambda { |duration, start, stop|
            { :conditions => ["abs(julianday(#{quoted_table_name}.#{connection.quote_column_name start}) - julianday(#{quoted_table_name}.#{connection.quote_column_name stop})) = ?", duration] }
          }
          scope :with_duration_over, lambda { |duration, start, stop|
            { :conditions => ["abs(julianday(#{quoted_table_name}.#{connection.quote_column_name start}) - julianday(#{quoted_table_name}.#{connection.quote_column_name stop})) > ?", duration] }
          }
          scope :with_duration_under, lambda { |duration, start, stop|
            { :conditions => ["abs(julianday(#{quoted_table_name}.#{connection.quote_column_name start}) - julianday(#{quoted_table_name}.#{connection.quote_column_name stop})) < ?", duration] }
          }
        end
      end

    end
  end
end
