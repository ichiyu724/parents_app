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

  describe "ユーザー新規登録" do
    context "新規登録が成功するとき" do
      it "必要事項が全て入力できている" do
        expect(user).to be_valid
      end
    end

    context "新規登録が失敗するとき" do
      it "usernameが空欄だとログインできない" do
        user.username = ""
        user.valid?
        expect(user.errors.full_messages).to include("ユーザー名は必須です")
      end
    end
  end
  
end
