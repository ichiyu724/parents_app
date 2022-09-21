FactoryBot.define do
  factory :post do
    title { "test用のtitle" }
    content { "これはtestです" }
    child_age_year { Faker::Number.within(range: 0..10).to_s + "歳" }
    child_age_month { Faker::Number.within(range: 0..11).to_s + "ヶ月" }
    content_image {Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/factories/test.jpg')) }
    association :user
    child_sex { ["未選択", "男の子", "女の子"].sample }
  end

  factory :fever, class: Post do
    title { "Fever" }
    content { "熱が下がらない" }
  end

  factory :cough, class: Post do
    title { "Cough" }
    content { "今度は咳が止まらない" }
  end
end
