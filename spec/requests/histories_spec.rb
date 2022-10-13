require 'rails_helper'

RSpec.describe "Histories", type: :request do
  let(:history) { create(:history) }
  let(:child) { create(:child) }
  let(:user) { create(:user) }
  let(:vaccination) { create(:vaccination) }
  
  describe "#index" do
    context "ログイン中のユーザー" do
      before do 
        sign_in user
        get user_child_histories_path(user_id: user.id, child_id: child.id)
      end
    
      it "ワクチンの接種記録一覧が表示できること" do
        expect(response).to have_http_status(200)
      end

      it 'タイトルが正しく表示されていること' do
        expect(response.body).to include("ワクチン記録")
      end
    end

    context "ログインユーザーでないユーザー" do
      before do
        get user_child_histories_path(user_id: user.id, child_id: child.id)
      end

      it "マイページにアクセスできないこと" do
        expect(response).to have_http_status(302)
      end

      it "ログイン画面にリダイレクトされること" do
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#new" do
    context "ログイン中のユーザー" do
      before do 
        sign_in user
        get new_user_child_history_path(child_id: child.id, user_id: user.id, vaccination_id: vaccination.id)
      end
    
      it "接種日の登録ページが表示できること" do
        expect(response).to have_http_status(200)
      end

      it 'タイトルが正しく表示されていること' do
        expect(response.body).to include("接種日を登録する")
      end
    end

    
  end
end
