require 'rails_helper'

RSpec.describe "Favorites", type: :system do
  let!(:user) { create(:user) }
  let!(:another_user) { create(:user) }
  let!(:post) { create(:post, user_id: user.id) }

  context "いいね" do
    scenario "いいねができること" do
      login(another_user)
      visit posts_path
      expect{
        find('.heart-btn').click
      }.to change { post.favorites.count }.by(1)
    end
  end

  context "いいね解除" do
    before do
      @favorite = FactoryBot.create(:favorite, user_id: another_user.id, post_id: post.id)
      login(another_user)
      visit posts_path
    end

    scenario "いいね解除ができること" do
      expect{
        find('.heart-btn').click
      }.to change { post.favorites.count }.by(-1)
    end
  end
end
