require 'rails_helper'

RSpec.describe "ユーザー新規登録", type: :system do
  let!(:user) { build(:user) }
  describe "ユーザー登録ページ" do
    context "ユーザー新規登録ができるとき" do
      before do
        visit new_user_registration_path
      end

      scenario "正しい情報を入力すればユーザー新規登録ができてマイページに移動する" do
        fill_in 'user[username]', with: user.username
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        fill_in 'user[password_confirmation]', with: user.password_confirmation
        expect{
          click_button '新規登録'
        }.to change { User.count }.by(1)
        expect(current_path).to eq posts_path
        expect(page).to have_content 'アカウント登録が完了しました'
      end
    end

    context "ユーザー新規登録ができないとき" do
      before do
        visit new_user_registration_path
      end

      scenario "誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる" do
        fill_in 'user[username]', with: ""
        fill_in 'user[email]', with: ""
        fill_in 'user[password]', with: ""
        fill_in 'user[password_confirmation]', with: ""
        expect{
          click_button '新規登録'
        }.to change { User.count }.by(0)
        expect(current_path).to eq('/users')
      end
    end
  end
end

RSpec.describe "ログイン", type: :system do
  let!(:user) { create(:user) }
  describe "ログインページ" do
    context "ログインできる時" do
      before do
        visit new_user_session_path
      end

      scenario "保存されているユーザー情報と合致すればログインできる" do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button "ログイン"
        expect(current_path).to eq user_path(user)
      end
    end

    context "ログインできない時" do
      before do
        visit new_user_session_path
      end
      scenario "保存されているユーザー情報と合致しないとログインできない" do
        fill_in 'user[email]', with: ""
        fill_in 'user[password]', with: ""
        click_button "ログイン"
        expect(current_path).to eq new_user_session_path
      end
    end
  end
end

RSpec.describe "ユーザーページ", type: :system do
  let!(:user) { create(:user, profile: "testだよ") }
  let!(:another_user) { create(:user, profile: "another_userだよ") }

  context "プロフィール" do
    before do
      login(user)
      visit user_path(user)
    end

    scenario "プロフィールが表示されていること" do
      expect(page).to have_content user.username
      expect(page).to have_content user.profile
      expect(page).to have_selector("img[src$='test.jpg']")
    end

    scenario "プロフィール編集ボタンを押すと編集ページへ遷移すること" do
      click_on "プロフィール編集"
      expect(current_path).to eq edit_user_path(user)
    end

    scenario "アカウント情報変更ボタンを押すと編集ページへ遷移すること" do
      click_on "アカウント情報変更"
      expect(current_path).to eq edit_user_registration_path
    end

    scenario "自分以外のプロフィールページでは編集ボタン、アカウント情報変更ボタンが表示されないこと" do
      visit user_path(another_user)
      expect(page).not_to have_content('プロフィール編集')
      expect(page).not_to have_content('アカウント情報変更')
    end
  end

  context "ユーザーの投稿" do
    let!(:post1) { create(:post, user_id: user.id, title: "test1", content: "testです") }
    
    before do
      login(user)
    end

    scenario "ユーザーの投稿が表示されていること" do
      visit user_path(user)
      expect(page).to have_link post1.title
      expect(page).to have_content post1.content
      expect(page).to have_selector("img[src$='test.jpg']")
    end

    scenario "「もっと見る」をクリックするとユーザーの投稿一覧ページに遷移すること" do
      visit user_path(user)
      find(".user-posts-link").click
      expect(current_path).to eq "/users/#{user.id}/user_posts"
    end
  end

  context "ユーザーのお気に入り" do
    let!(:user2) { create(:user, profile: "test2だよ") }
    let!(:post2) { create(:post, title: "test2", content: "test2です", user_id: user2.id) }
    let!(:favorite) { create(:favorite, post_id: post2.id, user: post2.user, user_id: user.id)}

    before do
      login(user)
    end

    scenario "ユーザーのお気に入りした投稿が表示されていること" do
      visit user_path(user)
      expect(page).to have_link post2.user.username
      expect(page).to have_link favorite.post.title
      expect(page).to have_content post2.content
      expect(page).to have_selector("img[src$='test.jpg']")
    end

    scenario "「もっと見る」をクリックするとユーザーのお気に入り一覧ページに遷移すること" do
      visit user_path(user)
      find(".user-favorites-link").click
      expect(current_path).to eq "/users/#{user.id}/favorites"
    end
  end
end

RSpec.describe "プロフィールの編集", type: :system do
  let!(:user) { create(:user, username: "山田", profile: "testだよ。") }
  let!(:another_user) { create(:user, profile: "another_userだよ") }

  context "プロフィールの編集ができる時" do
    before do
      login(user)
      visit edit_user_path(user)
    end

    scenario "ログインユーザーは自分のプロフィールを編集できること" do
      expect(
        find("#username-edit").value
      ).to eq(user.username)
      expect(
        find("#profile-edit").value
      ).to eq(user.profile)
      expect(page).to have_selector("img[src$='test.jpg']")

      attach_file "user[icon_image]", "#{Rails.root}/spec/factories/test2.jpg"
      fill_in 'user[username]', with: "#{user.username}くん"
      fill_in 'user[profile]', with: "#{user.profile}まだまだtestするよ"
      expect{
        click_button '更新'
      }.to change { User.count }.by(0)

      expect(current_path).to eq user_path(user)
      expect(page).to have_selector("img[src$='test2.jpg']")
      expect(page).to have_content "#{user.username}くん"
      expect(page).to have_content "#{user.profile}まだまだtestするよ"
    end
  end

  context "プロフィールの編集ができない" do
    before do
      login(user)
      visit edit_user_path(user)
    end

    scenario "usernameが空欄だと更新できない" do
      fill_in 'user[username]', with: ""
      click_button "更新"
        expect(current_path).to eq edit_user_path(user)
    end
  end

end
