require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:post) { create(:post, user_id: user.id) }
  
  describe "GET #index" do
    before do 
      sign_in user
      get users_path
    end
    it "ユーザー一覧が表示できること" do
      expect(response).to have_http_status(200)
    end

    it 'タイトルが正しく表示されていること' do
      expect(response.body).to include("ユーザー一覧")
    end

    it "ユーザー一覧にログイン中のuserが含まれていないこと" do
      user1 = FactoryBot.create(:user)
      sign_in(user1)
      expect(response).not_to include user1.id.to_s
    end
  end

  describe "GET #show" do
    context "ログイン中のユーザー" do
      it "マイページが表示できること" do
        sign_in user
        get user_path(user)
        expect(response).to have_http_status(200)
      end

      it "プロフィールの見出し名が表示できること" do
        sign_in user
        get user_path(user)
        expect(response.body).to include "プロフィール"
        expect(response.body).to include "#{user.username}さんの投稿"
        expect(response.body).to include "お気に入りした投稿"
      end
    end

    context "ログインユーザーでないユーザー" do
      it "マイページにアクセスできないこと" do
        get user_path(user)
        expect(response).to have_http_status(302)
      end

      it "ログイン画面にリダイレクトされること" do
        get user_path(user)
        expect(response).to redirect_to "/users/sign_in"
      end

    end
  end
end
