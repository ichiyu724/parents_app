require 'rails_helper'

RSpec.describe "フォロー、フォロワー", type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
    login(@user1)
  end

  scenario "ユーザーをフォロー、フォロー解除できる" do
    
    visit users_path
    
    binding.pry
    
    follow = find('button', text: 'フォロー')
    follow.click
    expect(page).to have_content 'フォロー解除'
    expect(@user2.follower.count).to eq(1)
    expect(@user1.following.count).to eq(1)
    
  end
end
