require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:user) { create(:user) }
  let!(:post) { create(:post, user_id: user.id) }
  
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
      expect(response).not_to include user.id.to_s
    end
  end

  
end
