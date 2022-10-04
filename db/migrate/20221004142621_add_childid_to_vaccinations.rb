class AddChildidToVaccinations < ActiveRecord::Migration[6.1]
  def change
    add_reference :vaccinations, :child, null: false, foreign_key: true
  end
end
