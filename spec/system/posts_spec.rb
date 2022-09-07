require 'rails_helper'

RSpec.describe "投稿一覧", type: :system do
  let(:user) { create(:user) }
  let(:post) { create(:post, title: "test", content: "testです")}

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
    end
  end

  scenario "いいねができること" do
    another_user = FactoryBot.create(:user)
    login(user)
    @favorite = FactoryBot.create(:favorite, user_id: another_user.id, post_id: post.id)
    visit posts_path
    find("#favorite-post").click
    expect(page).to have_selector '.heart-count1'
    expect(post.favorites.count).to eq(1)
  end
end
