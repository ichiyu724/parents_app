FactoryBot.define do
  factory :history do
    child { nil }
    vaccination { nil }
    date { "2022-09-29" }
    vaccinated { false }
  end
end
