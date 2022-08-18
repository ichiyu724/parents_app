require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }

  describe "ログイン" do
    it "emailとパスワードのバリデーションが設定できていること" do
    expect(user.valid?).to eq(true)
    end
  end
end
