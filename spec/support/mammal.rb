class Mammal < ActiveRecord::Base

  include Pacecar

  has_many :posts, as: :owner

end
