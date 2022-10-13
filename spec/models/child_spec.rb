require 'rails_helper'

RSpec.describe Child, type: :model do
  let(:child) { create(:child) }

  before do
    gender_select = ["未選択", "男の子", "女の子"]
    child.gender = gender_select.sample
  end

  describe "新規登録" do
    context "登録成功" do
      it "名前と生年月日のバリデーションが設定できていること" do
        expect(child.valid?).to eq(true)
      end
    end

    context "登録失敗" do
      it "名前が空欄だと投稿できない" do
        child.nickname = ""
        child.valid?
        expect(child.errors.full_messages).to include("名前を入力してください")
      end

      it "生年月日が空欄だと投稿できない" do
        child.birthdate = ""
        child.valid?
        expect(child.errors.full_messages).to include("生年月日を入力してください")
      end
    end
  end
end
