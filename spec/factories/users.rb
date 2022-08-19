FactoryBot.define do
  factory :user do
    email { Faker::Internet.free_email }
    username { Faker::Internet.username(specifier: 1..12) }
    password { 'password' }
    password_confirmation { 'password' }
    icon_image {Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/factories/test.jpg')) }
    profile { Faker::String.random }
  end
end
