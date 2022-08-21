require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:relationship) { FactoryBot.create(:relationship) }

  describe 'フォロー、フォロー解除の検証' do

    context "following_idとfolower_idがともに保存できる場合" do
      it "全てのパラメーターが揃っていれば保存できる" do
        expect(relationship).to be_valid
      end
    end

  end
end
