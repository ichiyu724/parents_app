FactoryBot.define do
  factory :history do
    association :child
    association :vaccination
    date { Faker::Date.in_date_period }
    vaccinated { false }
  end

  factory :hib_2, class: History do
    date { Date.parse("2022-10-13") }
  end

  factory :hib_3, class: History do
    date { Date.parse("2021-10-13") }
  end
end
