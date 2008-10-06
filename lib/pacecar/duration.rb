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
        named_scope :duration_between, lambda { |start, stop| { :select => "datediff(#{start}, #{stop}) as duration" } }
        named_scope :with_duration_of, lambda { |duration| { :conditions => ['duration = ?', duration] } }
        named_scope :with_duration_over, lambda { |duration| { :conditions => ['duration >= ?', duration] } }
        named_scope :with_duration_under, lambda { |duration| { :conditions => ['duration <= ?', duration] } }
      end

    end
  end
end
