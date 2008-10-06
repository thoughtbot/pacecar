require 'pacecar/boolean'
require 'pacecar/datetime'

module Pacecar

  def self.included(base)
    base.class_eval do
      extend ClassMethods
      include Pacecar::Boolean
      include Pacecar::Datetime
    end
  end

  module ClassMethods
    protected
    def columns_of_type(*types)
      columns.select { |column| types.include? column.type }.collect(&:name)
    end
  end

end
