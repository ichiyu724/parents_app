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
