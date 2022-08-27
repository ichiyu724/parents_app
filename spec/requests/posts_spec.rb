require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let(:user) { create(:user) }
  let(:article) { create(:post, user_id: user.id) }
  
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

  describe "#new" do
    context "ログイン中のユーザー" do
      before do 
        sign_in user
        get new_post_path
      end
    
      it "新規投稿画面が表示できること" do
        expect(response).to have_http_status(200)
      end

      it 'タイトルが正しく表示されていること' do
        expect(response.body).to include("相談を投稿する")
      end
    end

    context "ログインユーザーでないユーザー" do
      before do
        get new_post_path
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
      it "投稿が正常に完了するか" do
        expect do
          post posts_path, params: { post: FactoryBot.attributes_for(:post) }
        end.to change(user.posts, :count).by(1)
      end

      it "投稿成功後、リダイレクトするか" do
        post posts_path, params: { post: FactoryBot.attributes_for(:post) }
        expect(response).to redirect_to "/posts"
      end
    end

    context "パラメータが不正な場合" do
      before do
        sign_in user
      end
      it "投稿タイトルが空欄であれば登録されないこと" do
        expect do
          post posts_path, params: { post: FactoryBot.attributes_for(:post, title: "") }
        end.not_to change(user.posts, :count)
        expect(response.body).to include 'タイトルは必須です'
      end

      it "相談内容が空欄であれば登録されないこと" do
        expect do
          post posts_path, params: { post: FactoryBot.attributes_for(:post, content: "") }
        end.not_to change(user.posts, :count)
        expect(response.body).to include '相談内容は必須です'
      end
    end
  end

  describe "#show" do
    context "ログイン中のユーザー" do
      before do 
        sign_in user
        get post_path(article)
      end
    
      it "投稿詳細画面が表示できること" do
        expect(response).to have_http_status(200)
      end

      it 'タイトルが正しく表示されていること' do
        expect(response.body).to include("投稿詳細")
      end
    end

    context "ログインユーザーでないユーザー" do
      before do
        get post_path(article)
      end

      it "投稿詳細ページにアクセスできないこと" do
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
        get edit_post_path(article)
      end
    
      it "投稿編集画面が表示できること" do
        expect(response).to have_http_status(200)
      end

      it 'タイトルが正しく表示されていること' do
        expect(response.body).to include("相談を編集する")
      end
    end

    context "ログインユーザーでないユーザー" do
      before do
        get edit_post_path(article)
      end

      it "投稿編集ページにアクセスできないこと" do
        expect(response).to have_http_status(302)
      end

      it "ログイン画面にリダイレクトされること" do
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#update" do
    let(:fever) { FactoryBot.create :fever, user_id: user.id }
    
    context "パラメータが妥当な場合" do
      before do
        sign_in user
      end
      it '投稿タイトルが更新されること' do
        expect do
          put post_path(fever), params: { post: FactoryBot.attributes_for(:cough) }
        end.to change { Post.find(fever.id).title }.from('Fever').to('Cough')
      end

      it '相談内容が更新されること' do
        expect do
          put post_path(fever), params: { post: FactoryBot.attributes_for(:cough) }
        end.to change { Post.find(fever.id).content }.from('熱が下がらない').to('今度は咳が止まらない')
      end

      
    end
  end
end
