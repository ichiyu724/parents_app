require 'rails_helper'

RSpec.describe "フォロー、フォロワー", type: :system do
  before do
    @user1 = FactoryBot.create(:user, username: "user1", profile: "user1です")
    @user2 = FactoryBot.create(:user, username: "user2", profile: "user2です")
    login(@user2)
    visit users_path
  end

  scenario "ユーザーをフォロー、フォロー解除できる" do
    click_link "フォロー"
    expect(page).to have_content 'フォロー解除'
    click_link "フォロー解除"
    expect(page).to have_content 'フォロー'
  end
end
