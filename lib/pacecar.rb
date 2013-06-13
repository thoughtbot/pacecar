require 'pacecar/boolean'
require 'pacecar/helpers'
require 'pacecar/limit'
require 'pacecar/order'
require 'pacecar/polymorph'
require 'pacecar/presence'
require 'pacecar/search'
require 'pacecar/state'
require 'pacecar/version'

module Pacecar
  def self.included(base)
    base.class_eval do
      include Pacecar::Boolean
      include Pacecar::Limit
      include Pacecar::Order
      include Pacecar::Polymorph
      include Pacecar::Presence
      include Pacecar::Search
      include Pacecar::State
    end
  end
end

ActiveRecord::Base.send :include, Pacecar::Helpers
