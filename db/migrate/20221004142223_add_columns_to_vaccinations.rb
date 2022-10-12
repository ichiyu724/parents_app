class AddColumnsToVaccinations < ActiveRecord::Migration[6.1]
  def change
    add_column :vaccinations, :date, :date
    add_column :vaccinations, :vaccinated, :boolean
  end
end
