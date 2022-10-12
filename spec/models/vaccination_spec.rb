require 'rails_helper'

RSpec.describe Vaccination, type: :model do

  describe "Historyモデルとのアソシエーション" do
    let(:association) do
      described_class.reflect_on_association(target)
    end
    let(:vaccination) { create(:vaccination) }
    let(:child) { create(:child) }

    context "Historyモデルとのアソシエーション" do
      let(:target) { :histories }
      it "Historyとの関連付けはhas_manyであること" do
        expect(association.macro).to eq :has_many
      end

      it "Vaccinationが削除されたらHistoryも削除されること" do
        history = FactoryBot.create(:history, vaccination_id: vaccination.id, child_id: child.id)
        expect { vaccination.destroy }.to change(History, :count).by(-1)
      end
    end
  end
end
