require 'rails_helper'

RSpec.describe Favorite, type: :model do
  before do
    @user = FactoryBot.create(:user)
  end

  describe '正常値と異常値の確認' do
    context 'favoriteモデルのバリデーション' do
      it "user_idとpost_idがあれば保存できる" do
        expect(FactoryBot.create(:favorite, user_id: @user.id)).to be_valid
      end

      it "user_idがなければ無効な状態であること" do
        favorite = FactoryBot.create(:favorite, user_id: @user.id)
        favorite.user_id = nil
        expect(favorite).to be_invalid
      end

      it "post_idがなければ無効な状態であること" do
        favorite = FactoryBot.create(:favorite, user_id: @user.id)
        favorite.post_id = nil
        expect(favorite).to be_invalid
      end

      it "post_idが同じでもuser_idが違うと保存できる" do
        favorite = FactoryBot.create(:favorite, user_id: @user.id)
        user2 = FactoryBot.create(:user)
        expect(FactoryBot.create(:favorite, post_id: favorite.post_id, user_id: user2.id)).to be_valid
      end
    end
  end
end
