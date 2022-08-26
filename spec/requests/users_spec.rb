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
    let(:takashi) { FactoryBot.create :takashi }
    
    context "パラメータが妥当な場合" do
      before do
        sign_in takashi
      end
      it 'ユーザー名が更新されること' do
        expect do
          put user_path(takashi), params: { user: FactoryBot.attributes_for(:satoshi) }
        end.to change { User.find(takashi.id).username }.from('Takashi').to('Satoshi')
      end

      it 'リクエストが成功すること' do
        put user_path(takashi), params: { user: FactoryBot.attributes_for(:satoshi) }
        expect(response.status).to eq 302
      end

      it '更新後リダイレクトすること' do
        put user_path(takashi), params: { user: FactoryBot.attributes_for(:satoshi) }
        expect(response).to redirect_to "/users/#{takashi.id}"
      end
    end

    context 'パラメータが不正な場合' do
      before do
        sign_in takashi
      end
      it 'ユーザー名が空欄であれば更新されないこと' do
        expect do
          put user_path(takashi), params: { user: FactoryBot.attributes_for(:user, username: "") }
        end.to_not change(User.find(takashi.id), :username)
        expect(response.body).to include 'ユーザー名は必須です'
      end
    end
  end

  describe "#user_posts" do
    let(:user_posts) { FactoryBot.create(:post, user_id: user.id)}

    context "ログイン中のユーザー" do
      before do
        sign_in user
        get user_posts_path(user)
      end
      it "ユーザーの投稿一覧が表示できること" do
        expect(response).to have_http_status(200)
      end

      it "プロフィールの見出し名が表示できること" do
        expect(response.body).to include "#{user.username}さんの投稿"
      end
    end

    context "ログインユーザーでないユーザー" do
      before do
        get user_posts_path(user)
      end
      
      it "ユーザーの投稿一覧にアクセスできないこと" do
        expect(response).to have_http_status(302)
      end

      it "ログイン画面にリダイレクトされること" do
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "favorites" do
    let(:favorite_list) {FactoryBot.create(:post, user_id: user.id)}

    context "ログイン中のユーザー" do
      before do
        sign_in user
        get favorites_user_path(user)
      end
      it "ユーザーのお気に入り一覧が表示できること" do
        expect(response).to have_http_status(200)
      end

      it "見出し名が表示できること" do
        expect(response.body).to include "お気に入りした投稿"
      end
    end

    context "ログインユーザーでないユーザー" do
      before do
        get favorites_user_path(user)
      end
      
      it "ユーザーの投稿一覧にアクセスできないこと" do
        expect(response).to have_http_status(302)
      end

      it "ログイン画面にリダイレクトされること" do
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "followings, followers" do
    let(:following) { FactoryBot.create(:user) }
    let(:follower) { FactoryBot.create(:user) }

    context "ログイン中のユーザー" do
      before do
        sign_in user
      end
      it "ユーザーのフォロー中のユーザー一覧が表示できること" do
        get followings_user_path(user)
        expect(response).to have_http_status(200)
      end

      it "フォロー中という見出し名が表示できること" do
        get followings_user_path(user)
        expect(response.body).to include "フォロー中"
      end

      it "ユーザーをフォローしているユーザー一覧が表示できること" do
        get followers_user_path(user)
        expect(response).to have_http_status(200)
      end

      it "フォロワーという見出し名が表示できること" do
        get followers_user_path(user)
        expect(response.body).to include "フォロワー"
      end
    end
  end
end
