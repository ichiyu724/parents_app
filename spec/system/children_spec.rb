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

