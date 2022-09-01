FactoryBot.define do
  factory :comment do
    association :post
    #user {post.user}
    body { Faker::String.random }
  end
end
