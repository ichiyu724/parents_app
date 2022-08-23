require 'rails_helper'

RSpec.describe Favorite, type: :model do
  before do
    @favorite =  FactoryBot.build(:favorite)
    @user = FactoryBot.create(:user)
  end

  describe '正常値と異常値の確認' do
    context 'favoriteモデルのバリデーション' do
      it "user_idとpost_idがあれば保存できる" do
        expect(FactoryBot.create(:favorite, user_id: @user.id)).to be_valid
      end

    end
  end
end
