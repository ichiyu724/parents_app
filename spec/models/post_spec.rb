require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { create(:post) }

  before do
    gender_select = ["未選択", "男の子", "女の子"]
    post.child_sex = gender_select.sample
  end

    it "新規投稿のバリデーションが設定できていること" do
      expect(post.valid?).to eq(true)
    end
end
