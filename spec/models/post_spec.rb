require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { create(:post) }

  before do
    gender_select = ["未選択", "男の子", "女の子"]
    post.child_sex = gender_select.sample
  end

  describe "新規投稿" do
    context "投稿成功" do
      it "投稿タイトルと相談内容のバリデーションが設定できていること" do
        expect(post.valid?).to eq(true)
      end
    end

    context "投稿失敗" do
      it "投稿タイトルが空欄だと投稿できない" do
        post.title = ""
        post.valid?
        expect(post.errors.full_messages).to include("タイトルは必須です")
      end

      it "相談内容が空欄だと投稿できない" do
        post.content = ""
        post.valid?
        expect(post.errors.full_messages).to include("相談内容は必須です")
      end
    end
  end

  describe "各モデルとのアソシエーション" do
    let(:association) do
      described_class.reflect_on_association(target)
    end
    let(:post) { FactoryBot.create(:post) }
    let(:user) { FactoryBot.create(:user) }

    context "Favoriteモデルとのアソシエーション" do
      let(:target) { :favorites }
      it "Favoriteとの関連付けはhas_manyであること" do
        expect(association.macro).to eq :has_many
      end

      it "Postが削除されたらFavoriteも削除されること" do
        favorite = FactoryBot.create(:favorite, post_id: post.id, user_id: user.id)
        expect { post.destroy }.to change(Favorite, :count).by(-1)
      end
    end

    
  end
end
