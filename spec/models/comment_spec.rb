require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:comment) {create(:comment, user_id: user.id)}

  describe "コメント投稿" do
    context "コメント投稿成功" do
      it "コメント投稿のバリデーションが設定できていること" do
        expect(comment.valid?).to eq(true)
      end
    end

    context "コメント投稿失敗" do
      it "コメント内容が空欄だと投稿できない" do
        comment.body = ""
        comment.valid?
        expect(comment.errors.full_messages).to include("コメントを入力してください")
      end
    end
  end
end
