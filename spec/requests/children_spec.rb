require 'rails_helper'

RSpec.describe "Children", type: :request do
  let(:child) { create(:child) }
  let(:user) { create(:user) }
  
  describe "#index" do
    context "ログイン中のユーザー" do
      before do 
        sign_in user
        get user_children_path(user_id: user.id)
      end
    
      it "子供の一覧が表示できること" do
        expect(response).to have_http_status(200)
      end

      it 'タイトルが正しく表示されていること' do
        expect(response.body).to include("お子さん一覧")
      end
    end

    context "ログインユーザーでないユーザー" do
      before do
        get user_children_path(user_id: user.id)
      end

      it "マイページにアクセスできないこと" do
        expect(response).to have_http_status(302)
      end

      it "ログイン画面にリダイレクトされること" do
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#index" do
    context "ログイン中のユーザー" do
      before do 
        sign_in user
        get new_user_child_path(user_id: user.id)
      end
    
      it "子供の登録ページが表示できること" do
        expect(response).to have_http_status(200)
      end

      it 'タイトルが正しく表示されていること' do
        expect(response.body).to include("お子さんの情報登録")
      end
    end

    context "ログインユーザーでないユーザー" do
      before do
        get new_user_child_path(user_id: user.id)
      end

      it "マイページにアクセスできないこと" do
        expect(response).to have_http_status(302)
      end

      it "ログイン画面にリダイレクトされること" do
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
end
