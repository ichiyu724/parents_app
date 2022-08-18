require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }

  describe "ログイン" do
    context "ログインできるとき" do
      it "emailとパスワードのバリデーションが設定できていること" do
        expect(user.valid?).to eq(true)
      end
    end

    context "ログインできないとき" do
      it "emailが空欄だとログインできない" do
        user.email = ""
        user.valid?
        expect(user.errors.full_messages).to include("メールアドレスを入力してください")
      end

      it "passwordが空欄だとログインできない" do
        user.password = ""
        user.valid?
        expect(user.errors.full_messages).to include("パスワードを入力してください")
      end
    end

  end
end
