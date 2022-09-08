require 'rails_helper'

RSpec.describe "投稿一覧", type: :system do
  let(:user) { create(:user) }
  let(:post) { create(:post, title: "test", content: "testです", user: user)}

  scenario "登録済みの投稿が一覧で表示できること" do
    login(user)
    post1 = FactoryBot.create(:post, title: "test1", content: "test_first")
    post2 = FactoryBot.create(:post, title: "test2", content: "test_second")
    post3 = FactoryBot.create(:post, title: "test3", content: "test_third")
    @posts = [post1, post2, post3]
    visit posts_path
    @posts.each do |post|
      expect(page).to have_link post.user.username
      expect(page).to have_link post.title
      expect(page).to have_content post.content
      expect(page).to have_selector("img[src$='test.jpg']")
      expect(page).to have_selector "#regular-heart-btn"
      expect(page).to have_selector ".comment-btn"
    end
  end
end

RSpec.describe "新規投稿", type: :system do
  let!(:user) { create(:user) }
  let!(:post) { build(:post, title: "test", content: "test用") }

  before do
    login(user)
    visit new_post_path
  end

  scenario "新規投稿ができること" do
    fill_in 'post[title]', with: post.title
    select '男の子', from: 'post[child_sex]'
    select '2歳', from: 'post[child_age_year]'
    select '5ヶ月', from: 'post[child_age_month]'
    fill_in 'post[content]', with: post.content
    attach_file "post[content_image]", "#{Rails.root}/spec/factories/test2.jpg"
    expect{
      click_button '投稿する'
    }.to change { Post.count }.by(1)
    expect(current_path).to eq posts_path
  end

  scenario "誤った情報では投稿できないこと" do
    fill_in 'post[title]', with: ""
    fill_in 'post[content]', with: ""
    expect{
      click_button '投稿する'
    }.to change { Post.count }.by(0)
    expect(current_path).to eq new_post_path
  end
end



end
