require 'rails_helper'

RSpec.describe "Children", type: :request do
  let!(:child) { create(:child) }
  let!(:user) { create(:user) }

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

  describe "#new" do
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

  describe "#create" do
    context "パラメータが正常な場合" do
      before do
        sign_in user
      end
      it "子供の登録が正常に完了するか" do
        expect do
          post user_children_path(user_id: user.id), params: { child: FactoryBot.attributes_for(:child) }
        end.to change(user.children, :count).by(1)
      end

      it "登録成功後、リダイレクトするか" do
        post user_children_path(user_id: user.id), params: { child: FactoryBot.attributes_for(:child) }
        expect(response).to redirect_to user_children_path(user_id: user.id)
      end
    end
    
    context "パラメータが不正な場合" do
      before do
        sign_in user
      end
      it "名前が空欄であれば登録されないこと" do
        expect do
          post user_children_path(user_id: user.id), params: { child: FactoryBot.attributes_for(:child, nickname: "") }
        end.not_to change(user.children, :count)
        expect(response.body).to include '名前を入力してください'
      end

      it "生年月日が空欄であれば登録されないこと" do
        expect do
          post user_children_path(user_id: user.id), params: { child: FactoryBot.attributes_for(:child, birthdate: "") }
        end.not_to change(user.posts, :count)
        expect(response.body).to include '生年月日を入力してください'
      end
    end
  end

  describe "#show" do
    context "ログイン中のユーザー" do
      before do 
        sign_in user
        get user_child_path(child, user_id: user.id)
      end

      it "ワクチンスケジュールが表示できること" do
        expect(response).to have_http_status(200)
      end

      it 'タイトルが正しく表示されていること' do
        expect(response.body).to include("ワクチン接種スケジュール")
      end
    end

    context "ログインユーザーでないユーザー" do
      before do
        get user_child_path(child, user_id: user.id)
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
