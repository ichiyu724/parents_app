class CreateChildren < ActiveRecord::Migration[6.1]
  def change
    create_table :children do |t|
      t.date :birthdate
      t.string :gender
      t.string :nickname
      t.integer :user_id

      t.timestamps
    end
  end
end
