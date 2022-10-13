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

    context "ログインユーザーでないユーザー" do
      before do
        get new_user_child_history_path(child_id: child.id, user_id: user.id, vaccination_id: vaccination.id)
      end

      it "マイページにアクセスできないこと" do
        expect(response).to have_http_status(302)
      end

      it "ログイン画面にリダイレクトされること" do
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#create" do
    context "パラメータが正常な場合" do
      before do
        sign_in user
      end
      it "接種日の登録が正常に完了するか" do
        expect do
          post user_child_histories_path(user_id: user.id, child_id: child.id), params: { history: FactoryBot.attributes_for(:history, vaccination_id: vaccination.id) }
        end.to change(child.histories, :count).by(1)
      end

      it "登録成功後、リダイレクトするか" do
        post user_child_histories_path(user_id: user.id, child_id: child.id), params: { history: FactoryBot.attributes_for(:history, vaccination_id: vaccination.id) }
        expect(response).to redirect_to user_child_histories_path(user_id: user.id, child_id: child.id)
      end
    end
    
    context "パラメータが不正な場合" do
      before do
        sign_in user
      end
      it "接種日が空欄であれば登録されないこと" do
        expect do
          post user_child_histories_path(user_id: user.id, child_id: child.id), params: { history: FactoryBot.attributes_for(:history, vaccination_id: vaccination.id, date: "") }
        end.not_to change(child.histories, :count)
      end
    end
  end
end
