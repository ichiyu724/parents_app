FactoryBot.define do
  factory :post do
    title { Faker::String.random }
    content { Faker::String.random }
    child_age_year { Faker::Number.within(range: 0..10).to_s + "歳" }
    child_age_month { Faker::Number.within(range: 0..11).to_s + "ヶ月" }
    content_image {Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/factories/test.jpg')) }
    association :user
    #user_id { FactoryBot.create(:user).id }
    child_sex { ["未選択", "男の子", "女の子"].sample }
  end
end
