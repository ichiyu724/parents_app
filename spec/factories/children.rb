FactoryBot.define do
  factory :child do
    birthdate { Faker::Date.in_date_period }
    gender { ["未選択", "男の子", "女の子"].sample }
    nickname { Faker::Internet.username(specifier: 1..12) }
    association :user
  end

  factory :hanako, class: Child do
    nickname { "Hanako" }
    birthdate { Date.parse("2022-10-13") }
  end

  factory :taro, class: Child do
    nickname { "Taro" }
    birthdate { Date.parse("2021-10-13") }
  end
end
