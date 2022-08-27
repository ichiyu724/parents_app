FactoryBot.define do
  factory :user do
    email { Faker::Internet.free_email }
    username { Faker::Internet.username(specifier: 1..12) }
    password { 'password' }
    password_confirmation { 'password' }
    icon_image {Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/factories/test.jpg')) }
    profile { Faker::String.random }
  end

  factory :takashi, class: User do
    username { "Takashi" }
    profile { "hello" }
    email { "takashi@example.com" }
    password { "password" } 
  end

  factory :satoshi, class: User do
    username { "Satoshi" }
    profile { "hellohello" }
  end

end
