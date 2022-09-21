FactoryBot.define do
  factory :comment do
    association :post
    association :user
    body { "test用のコメント" }
  end
end
