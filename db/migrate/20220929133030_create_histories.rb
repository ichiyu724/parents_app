class CreateHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :histories do |t|
      t.references :child, null: false, foreign_key: true
      t.references :vaccination, null: false, foreign_key: true
      t.date :date
      t.boolean :vaccinated

      t.timestamps
    end
  end
end
