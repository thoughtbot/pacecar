class User < ActiveRecord::Base

  include Pacecar

  has_many :posts, as: :owner
  has_many :comments
  has_many :articles

end
