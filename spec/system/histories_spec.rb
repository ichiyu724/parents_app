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
        expect(page).to have_content "接種日を登録する"
      end
    end
  end
end