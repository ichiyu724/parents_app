require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let(:user) { create(:user) }
  let(:post) { create(:post, user_id: user.id) }
  
  describe "#index" do
    context "ログイン中のユーザー" do
      before do 
        sign_in user
        get posts_path
      end
    
      it "投稿一覧が表示できること" do
        expect(response).to have_http_status(200)
      end

      it 'タイトルが正しく表示されていること' do
        expect(response.body).to include("投稿一覧")
      end
    end

    context "ログインユーザーでないユーザー" do
      before do
        get posts_path
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
