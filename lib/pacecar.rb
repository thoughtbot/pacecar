require 'pacecar/boolean'
require 'pacecar/datetime'
require 'pacecar/presence'
require 'pacecar/order'
require 'pacecar/polymorph'
require 'pacecar/search'

module Pacecar
  def self.included(base)
    base.class_eval do
      extend ClassMethods
      include Pacecar::Boolean
      include Pacecar::Datetime
      include Pacecar::Presence
      include Pacecar::Order
      include Pacecar::Polymorph
      include Pacecar::Search
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
