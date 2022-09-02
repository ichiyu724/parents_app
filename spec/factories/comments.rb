FactoryBot.define do
  factory :comment do
    association :post
    association :user
    body { Faker::String.random }
  end
end
