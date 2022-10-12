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
  end
end
