require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:relationship) { FactoryBot.create(:relationship) }

  describe 'フォロー、フォロー解除の検証' do

    context "following_idとfolower_idがともに保存できる場合" do
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
  end
end
