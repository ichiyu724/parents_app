FactoryBot.define do
  factory :child do
    birthdate { "2022-09-25" }
    gender { "MyString" }
    nickname { "MyString" }
    user_id { 1 }
  end
end
