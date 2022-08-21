require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:relationship) { FactoryBot.create(:relationship) }

  describe 'フォロー、フォロー解除の検証' do

    context "following_idとfollower_idがともに保存できる場合" do
      it "全てのパラメーターが揃っていれば保存できる" do
        expect(relationship).to be_valid
      end
    end

    context "保存できない場合" do
      it "following_idがnilの場合は保存できない" do
        relationship.following_id = nil
        relationship.valid?
        expect(relationship.errors[:following_id]).to include("を入力してください")
      end

      it "follower_idがnilの場合は保存できない" do
        relationship.follower_id = nil
        relationship.valid?
        expect(relationship.errors[:follower_id]).to include("を入力してください")
      end
    end

    context "一意性の検証" do
      before do
        @relation = FactoryBot.create(:relationship)
        @user1 = FactoryBot.build(:relationship)
      end
      it "following_idとfollower_idの組み合わせは一意でなければ保存できない" do
        relation2 = FactoryBot.build(:relationship, following_id: @relation.following_id, follower_id: @relation.follower_id)
        relation2.valid?
        expect(relation2.errors[:following_id]).to include("はすでに存在します")
      end

      it "following_idが同じでもfollower_idが違うなら保存できる" do
        relation2 = FactoryBot.build(:relationship, following_id: @relation.following_id, follower_id: @user1.follower_id)
        expect(relation2).to be_valid
      end

      it "following_idが違うならfollower_idが同じでも保存できる" do
        relation2 = FactoryBot.build(:relationship, following_id: @user1.following_id, follower_id: @relation.follower_id)
        expect(relation2).to be_valid
      end
    end
  end
end
