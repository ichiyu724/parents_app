require 'rails_helper'

RSpec.describe "子供の一覧", type: :system do
  let!(:user) { create(:user) }
  let!(:child) { create(:child, user_id: user.id)}

  before do
    login(user)
  end

  scenario "登録済みの子供が一覧で表示できること" do
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

  scenario "編集リンクを押すと編集ページへ遷移すること" do
    visit user_children_path(user_id: user.id)
    click_on "編集"
    expect(current_path).to eq edit_user_child_path(child, user_id: user.id)
  end

  scenario "登録解除リンクを押すと子供の情報が削除され子供の一覧ページへ遷移すること" do
    visit user_children_path(user_id: user.id)
    expect{
      click_on '登録解除'
    }.to change { Child.count }.by(-1)
    expect(current_path).to eq user_children_path(user_id: user.id)
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

RSpec.describe "子供の編集", type: :system do
  let!(:user) { create(:user) }
  let!(:child) { create(:child, birthdate: Date.parse("2022-10-13"), gender: "男の子", nickname: "Taro", user: user)}

  before do
    login(user)
    visit edit_user_child_path(child, user_id: user.id)
  end

  context "子供の編集ができる時" do
    scenario "ログインユーザーは子供を編集できること" do
      expect(
        find("#nickname").value
      ).to eq(child.nickname)
      
      fill_in 'child[nickname]', with: "Hanako"
      fill_in 'child[birthdate]', with: Date.parse("2021-12-31")
      select '女の子', from: 'child[gender]'
      expect{
        click_on '更新する'
      }.to change { Post.count }.by(0)
      
      expect(current_path).to eq user_children_path(user_id: user.id)
      expect(page).to have_content "Hanako"
      expect(page).to have_content "女の子"
      expect(page).to have_content Date.parse("2021-12-31")
    end
  end

  context "子供の編集ができない" do
    scenario "名前が空欄だと更新できない" do
      fill_in 'child[nickname]', with: ""
      click_on '更新する'
      expect(current_path).to eq "/users/#{user.id}/children/#{child.id}"
    end

    scenario "生年月日が空欄だと更新できない" do
      fill_in 'child[birthdate]', with: ""
      click_on '更新する'
      expect(current_path).to eq "/users/#{user.id}/children/#{child.id}"
    end
  end
end