require 'rails_helper'

RSpec.describe "接種記録の一覧", type: :system do
  let!(:user) { create(:user) }
  let!(:child) { create(:child, user_id: user.id)}

  before do
    login(user)
  end

  context "全てのワクチン未接種時" do
    scenario "ワクチンの記録を一覧で表示できること" do
      hib_1 = FactoryBot.create(:vaccination, name: "ヒブ", period: "1回目")
      hib_2 = FactoryBot.create(:vaccination, name: "ヒブ", period: "2回目")
      hib_3 = FactoryBot.create(:vaccination, name: "ヒブ", period: "3回目")
      @vaccinations = [hib_1, hib_2, hib_3]
      visit user_child_histories_path(user_id: user.id, child_id: child.id)
      @vaccinations.each do |vaccination|
        expect(page).to have_content vaccination.name
        expect(page).to have_content vaccination.period
        expect(page).to have_content "接種日を登録する"
      end
    end
  end

  context "接種済のワクチンがある時" do
    scenario "ワクチンの記録を一覧で表示できること" do
      hib_1 = FactoryBot.create(:vaccination, name: "ヒブ", period: "1回目")
      hib_2 = FactoryBot.create(:vaccination, name: "ヒブ", period: "2回目")
      hib_3 = FactoryBot.create(:vaccination, name: "ヒブ", period: "3回目")
      history = FactoryBot.create(:history, vaccination_id: hib_1.id, child_id: child.id, date: Date.parse("2022-10-14"), vaccinated: true)
      @vaccinations = [hib_1, hib_2, hib_3]
      visit user_child_histories_path(user_id: user.id, child_id: child.id)
      @vaccinations.each do |vaccination|
        expect(page).to have_content vaccination.name
        expect(page).to have_content vaccination.period
        expect(page).to have_content history.date
        expect(page).to have_content "修正する"
        expect(page).to have_content "削除"
        expect(page).to have_content "接種日を登録する"
      end
    end

    scenario "削除リンクを押すとワクチン記録が削除されワクチン記録ページへリダイレクトすること" do
      hib_4 = FactoryBot.create(:vaccination, name: "ヒブ", period: "4回目")
      history = FactoryBot.create(:history, vaccination_id: hib_4.id, child_id: child.id, date: Date.parse("2022-10-14"), vaccinated: true)
      visit user_child_histories_path(user_id: user.id, child_id: child.id)
      expect{
        click_on '削除'
      }.to change { History.count }.by(-1)
      expect(current_path).to eq user_child_histories_path(user_id: user.id, child_id: child.id)
    end
  end
end

RSpec.describe "接種記録の登録", type: :system do
  let!(:user) { create(:user) }
  let!(:child) { create(:child, user_id: user.id)}
  let!(:vaccination) { create(:vaccination) }
  let!(:history) { create(:history, child_id: child.id, vaccination_id: vaccination.id) }

  before do
    login(user)
    visit new_user_child_history_path(user_id: user.id, child_id: child.id, vaccination_id: vaccination.id)
  end

  scenario "接種記録登録ができること" do
    fill_in 'history[date]', with: Date.parse("2022-10-14")
    expect{
      click_button '登録する'
    }.to change { History.count }.by(1)
    expect(current_path).to eq user_child_histories_path(user_id: user.id, child_id: child.id)
  end

  scenario "接種日が空欄では登録できないこと" do
    fill_in 'history[date]', with: ""
    expect{
      click_button '登録する'
    }.to change { Child.count }.by(0)
    expect(current_path).to eq "/users/#{user.id}/children/#{child.id}/histories"
  end
end

RSpec.describe "接種記録の修正", type: :system do
  let!(:user) { create(:user) }
  let!(:child) { create(:child, user_id: user.id)}
  let!(:vaccination) { create(:vaccination) }
  let!(:history) { create(:history, child_id: child.id, vaccination_id: vaccination.id, date: Date.parse("2022-10-14")) }

  before do
    login(user)
    visit edit_user_child_history_path(history, user_id: user.id, child_id: child.id, vaccination_id: vaccination.id)
  end

  scenario "接種記録修正ができること" do
    fill_in 'history[date]', with: Date.parse("2021-1-21")
    expect{
      click_button '更新する'
    }.to change { History.count }.by(0)
    expect(current_path).to eq user_child_histories_path(user_id: user.id, child_id: child.id)
  end

  scenario "接種日が空欄では更新できないこと" do
    fill_in 'history[date]', with: ""
    expect{
      click_button '更新する'
    }.to change { History.count }.by(0)
    expect(current_path).to eq "/users/#{user.id}/children/#{child.id}/histories/#{history.id}"
  end
end