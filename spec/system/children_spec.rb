require 'rails_helper'

RSpec.describe "子供の一覧", type: :system do
  let(:user) { create(:user) }
  let(:child) { create(:child, user_id: user.id)}

  scenario "登録済みの子供が一覧で表示できること" do
    login(user)
    child1 = FactoryBot.create(:child, user_id: user.id)
    child2 = FactoryBot.create(:child, user_id: user.id)
    child3 = FactoryBot.create(:child, user_id: user.id)
    @children = [child1, child2, child3]
    visit user_children_path(user_id: user.id)
    @children.each do |child|
      expect(page).to have_link child.nickname
      expect(page).to have_content child.gender
      expect(page).to have_content child.birthdate
      expect(page).to have_content "編集"
      expect(page).to have_content "登録解除"
      expect(page).to have_content "お子さんの登録"
    end
  end
end

RSpec.describe "新規登録", type: :system do
  let!(:user) { create(:user) }
  let!(:child) { create(:child, user_id: user.id)}

  before do
    login(user)
    visit new_user_child_path(user_id: user.id)
  end

  scenario "子供の新規登録ができること" do
    fill_in 'child[nickname]', with: child.nickname
    fill_in 'child[birthdate]', with: child.birthdate
    select '男の子', from: 'child[gender]'
    expect{
      click_button '登録する'
    }.to change { Child.count }.by(1)
    expect(current_path).to eq user_children_path(user_id: user.id)
  end

  scenario "誤った情報では投稿できないこと" do
    fill_in 'child[nickname]', with: ""
    fill_in 'child[birthdate]', with: ""
    expect{
      click_button '登録する'
    }.to change { Child.count }.by(0)
    expect(current_path).to eq "/users/#{user.id}/children"
  end
end
