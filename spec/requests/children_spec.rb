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

  describe "#edit" do
    context "ログイン中のユーザー" do
      before do 
        sign_in user
        get edit_user_child_path(child, user_id: user.id)
      end
    
      it "子供の編集ページが表示できること" do
        expect(response).to have_http_status(200)
      end

      it 'タイトルが正しく表示されていること' do
        expect(response.body).to include("お子さんの情報編集")
      end
    end

    context "ログインユーザーでないユーザー" do
      before do
        get edit_user_child_path(child, user_id: user.id)
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
    let(:hanako) { FactoryBot.create :hanako, user_id: user.id }
      
    context "パラメータが妥当な場合" do
      before do
        sign_in user
      end
      it '子供の名前が更新されること' do
        expect do
          put user_child_path(hanako, user_id: user.id), params: { child: FactoryBot.attributes_for(:taro) }
        end.to change { Child.find(hanako.id).nickname }.from('Hanako').to('Taro')
      end

      it '生年月日が更新されること' do
        expect do
          put user_child_path(hanako, user_id: user.id), params: { child: FactoryBot.attributes_for(:taro) }
        end.to change { Child.find(hanako.id).birthdate }.from(Date.parse("2022-10-13")).to(Date.parse("2021-10-13"))
      end

      it 'リクエストが成功すること' do
        put user_child_path(hanako, user_id: user.id), params: { child: FactoryBot.attributes_for(:taro) }
        expect(response.status).to eq 302
      end

      it '更新後リダイレクトすること' do
        put user_child_path(hanako, user_id: user.id), params: { child: FactoryBot.attributes_for(:taro) }
        expect(response).to redirect_to user_children_path
      end
    end

    context 'パラメータが不正な場合' do
      before do
        sign_in user
      end
      it '名前が空欄であれば更新されないこと' do
        expect do
          put user_child_path(hanako, user_id: user.id), params: { child: FactoryBot.attributes_for(:taro, nickname: "") }
        end.to_not change(Child.find(hanako.id), :nickname)
        expect(response.body).to include '名前を入力してください'
      end

      it '生年月日が空欄であれば更新されないこと' do
        expect do
          put user_child_path(hanako, user_id: user.id), params: { child: FactoryBot.attributes_for(:taro, birthdate: "") }
        end.to_not change(Child.find(hanako.id), :birthdate)
        expect(response.body).to include '生年月日を入力してください'
      end
    end
  end
end
