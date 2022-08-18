FactoryBot.define do
  factory :user do
    email { 'hogehoge@example.com' }
    username { 'hoge' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
