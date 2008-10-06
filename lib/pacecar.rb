require 'pacecar/boolean'
require 'pacecar/datetime'
require 'pacecar/presence'
require 'pacecar/order'

module Pacecar
  def self.included(base)
    base.class_eval do
      extend ClassMethods
      include Pacecar::Boolean
      include Pacecar::Datetime
      include Pacecar::Presence
      include Pacecar::Order
    end
  end

  module ClassMethods
    protected
    def column_names_for_type(*types)
      columns.select { |column| types.include? column.type }.collect(&:name)
    end
    def column_names
      columns.collect(&:name)
    end
  end
end
