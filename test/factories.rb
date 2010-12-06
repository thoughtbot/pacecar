Factory.sequence(:age) { |n| n.to_i }
Factory.sequence(:rating) { |n| n.to_f }

Factory.define :comment do |f|
  f.association :user
end

Factory.define :mammal do |f|
end

Factory.define :post do |f|
end

Factory.define :user do |f|
  f.age     { Factory.next :age }
  f.rating  { Factory.next :rating }
end
