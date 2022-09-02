require 'rails_helper'

RSpec.describe "ユーザー新規登録", type: :system do
  let(:user) { create(:user) }

  context "ユーザー新規登録ができるとき" do
    scenario "正しい情報を入力すればユーザー新規登録ができてマイページに移動する" do
      visit root_path
      expect(page).to have_content('新規登録')
    end
  end
end
