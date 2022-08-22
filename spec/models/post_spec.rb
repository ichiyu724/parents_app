require 'rails_helper'

RSpec.describe Post, type: :model do

  let(:post) { create(:post) }

    it "新規投稿のバリデーションが設定できていること" do
      expect(post.valid?).to eq(true)
    end
end
