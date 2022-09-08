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
    expect(current_path).to eq "/posts"
  end
end

RSpec.describe "投稿詳細", type: :system do
  let!(:user) { create(:user) }
  let!(:another_user) { create(:user) }
  let!(:post) { create(:post, title: "test", content: "test用", user: user) }
  let!(:another_post) { create(:post, title: "another", content: "another用", user: another_user) }

  before do
    login(user)
    visit post_path(post)
  end

  scenario "投稿の詳細が表示されていること" do
    expect(page).to have_content post.user.username
    expect(page).to have_content post.title
    expect(page).to have_content post.child_sex
    expect(page).to have_content post.child_age_year
    expect(page).to have_content post.child_age_month
    expect(page).to have_content post.content
    expect(page).to have_selector("img[src$='test.jpg']")
    expect(page).to have_selector(".heart-btn")
    expect(page).to have_selector(".comment-btn")
    expect(page).to have_content post.created_at.strftime('%Y/%m/%d %H:%M')
  end

  scenario "編集リンクを押すと編集ページへ遷移すること" do
    click_on "編集"
    expect(current_path).to eq edit_post_path(post)
  end

  scenario "削除リンクを押すと投稿が削除され投稿一覧ページへ遷移すること" do
    expect{
      click_on '削除'
    }.to change { Post.count }.by(-1)
    expect(current_path).to eq posts_path
  end

  scenario "投稿一覧に戻るを押すと投稿一覧ページへ遷移すること" do
    click_on '投稿一覧に戻る'
    expect(current_path).to eq posts_path
  end

  scenario "自分以外の投稿詳細ページでは編集ボタン、削除ボタンが表示されないこと" do
    visit post_path(another_post)
    expect(page).not_to have_content('編集')
    expect(page).not_to have_content('削除')
  end
end

RSpec.describe "投稿の編集", type: :system do
  let!(:user) { create(:user) }
  let!(:post) { create(:post, title: "test", content: "testです", child_sex: "男の子", child_age_year: "2歳", child_age_month: "3ヶ月", user: user)}

  before do
    login(user)
    visit edit_post_path(post)
  end

  context "投稿編集ができる時" do
    scenario "ログインユーザーは自分の投稿を編集できること" do
      expect(
        find("#title").value
      ).to eq(post.title)
      
      fill_in 'post[title]', with: "#{post.title}" + "します"
      select '女の子', from: 'post[child_sex]'
      select '3歳', from: 'post[child_age_year]'
      select '8ヶ月', from: 'post[child_age_month]'
      fill_in 'post[content]', with: "#{post.content}" + "が何か"
      attach_file "post[content_image]", "#{Rails.root}/spec/factories/test2.jpg"
      expect{
        click_button '更新する'
      }.to change { Post.count }.by(0)
      
      expect(current_path).to eq post_path(post)
      expect(page).to have_selector("img[src$='test2.jpg']")
      expect(page).to have_content "#{post.title}します"
      expect(page).to have_content "女の子"
      expect(page).to have_content "3歳"
      expect(page).to have_content "8ヶ月"
      expect(page).to have_content "#{post.content}が何か"
    end

    scenario "投稿詳細に戻るを押すと投稿詳細ページへ遷移すること" do
      click_on '投稿詳細に戻る'
      expect(current_path).to eq post_path(post)
    end
  end

  context "投稿の編集ができない" do
    scenario "タイトルが空欄だと更新できない" do
      fill_in 'post[title]', with: ""
      click_button '更新する'
      expect(current_path).to eq "/posts/#{post.id}"
    end

    scenario "相談内容が空欄だと更新できない" do
      fill_in 'post[content]', with: ""
      click_button '更新する'
      expect(current_path).to eq "/posts/#{post.id}"
    end
  end
end