class Post < ActiveRecord::Base

  include Pacecar

  PUBLICATION_STATES = %w(Draft Submitted Rejected Accepted).freeze
  TYPES = %w(Free Open Private Anonymous PostModern).freeze

  belongs_to :owner, polymorphic: true

  has_state :publication_state
  has_state :post_type, with: TYPES
  has_polymorph :owner

end
