class User < ActiveRecord::Base

  include Pacecar

  has_many :posts, :as => :owner
  has_many :comments
  has_many :articles

  has_ranking :comments
  has_recent_records :comments
  has_recent_records :posts, :comments

end
