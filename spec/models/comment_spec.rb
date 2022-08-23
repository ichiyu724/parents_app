require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post) }
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

    context "user_idとpost_idの保存" do
      it "user_idとpost_idがあれば保存できる" do
        expect(FactoryBot.create(:comment, user_id: user.id, post_id: post.id)).to be_valid
      end

      it "user_idがなければ無効な状態であること" do
        comment.user_id = nil
        expect(comment).to be_invalid
      end

      it "post_idがなければ無効な状態であること" do
        comment.post_id = nil
        expect(comment).to be_invalid
      end
    end
  end
end
