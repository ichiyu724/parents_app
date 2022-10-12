class RemoveColumnsFromVaccination < ActiveRecord::Migration[6.1]
  def change
    remove_column :vaccinations, :date, :date
    remove_column :vaccinations, :vaccinated, :boolean
  end
end
