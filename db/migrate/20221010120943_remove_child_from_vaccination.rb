class RemoveChildFromVaccination < ActiveRecord::Migration[6.1]
  def change
    remove_reference :vaccinations, :child, null: false
  end
end
