require 'rails_helper'

RSpec.describe History, type: :model do
  let(:history) { create(:history) }

  describe "接種日登録" do
    context "登録成功" do
      it "接種日のバリデーションが設定できていること" do
        expect(history.valid?).to eq(true)
      end
    end

    context "登録失敗" do
      it "接種日が空欄だと投稿できない" do
        history.date = ""
        history.valid?
        expect(history.errors.full_messages).to include("接種日を入力してください")
      end
    end
  end
end
