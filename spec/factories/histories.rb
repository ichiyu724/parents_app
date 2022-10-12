FactoryBot.define do
  factory :history do
    association :child
    association :vaccination
    date { Faker::Date.in_date_period }
    vaccinated { false }
  end
end
