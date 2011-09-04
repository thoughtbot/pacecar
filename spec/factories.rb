FactoryGirl.define do

  sequence :age do |n|
    n.to_i
  end

  sequence :rating do |n|
    n.to_f
  end

  factory :comment do
    association :user
  end

  factory :mammal do
  end

  factory :post do
  end

  factory :user do
    age     { Factory.next :age }
    rating  { Factory.next :rating }
  end

end
