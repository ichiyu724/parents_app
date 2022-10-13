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
  end
end
