require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:post) { create(:post, user_id: user.id) }
  
  describe "#index" do
    context "ログイン中のユーザー" do
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

    context do
      before do
        get users_path
      end

      it "マイページにアクセスできないこと" do
        expect(response).to have_http_status(302)
      end

      it "ログイン画面にリダイレクトされること" do
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#show" do
    context "ログイン中のユーザー" do
      before do
        sign_in user
        get user_path(user)
      end
      it "マイページが表示できること" do
        expect(response).to have_http_status(200)
      end

      it "プロフィールの見出し名が表示できること" do
        expect(response.body).to include "プロフィール"
        expect(response.body).to include "#{user.username}さんの投稿"
        expect(response.body).to include "お気に入りした投稿"
      end
    end

    context "ログインユーザーでないユーザー" do
      before do
        get user_path(user)
      end
      
      it "マイページにアクセスできないこと" do
        expect(response).to have_http_status(302)
      end

      it "ログイン画面にリダイレクトされること" do
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#edit" do
    context "ログイン中のユーザー" do
      before do 
        sign_in user
        get edit_user_path(user)
      end

      it "ユーザー編集ページが表示されること" do
        expect(response).to have_http_status(200)
      end

      it 'プロフィール編集の見出し名が正しく表示されていること' do
        expect(response.body).to include("プロフィール編集")
      end
    end

    context "ログインユーザーでないユーザー" do
      before do
        get edit_user_path(user)
      end
      
      it "マイページにアクセスできないこと" do
        expect(response).to have_http_status(302)
      end

      it "ログイン画面にリダイレクトされること" do
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#update" do
    context "ログイン中のユーザー" do
      before do
        sign_in user
        get edit_user_path(user)
      end

      it 'ユーザー名が更新されること' do
        user.update(username: "hogehoge", profile: "hello")
        expect(user.reload.username).to eq "hogehoge"
        expect(user.reload.profile).to eq "hello"
      end
    end
  end
end
