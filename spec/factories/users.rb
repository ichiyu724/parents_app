FactoryBot.define do
  factory :user do
    email { 'hogehoge@example.com' }
    username { 'hoge' }
    password { 'password' }
  end
end
