class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :title
      t.integer :child_sex
      t.integer :child_age_year
      t.integer :child_age_month
      t.text :content
      t.string :content_image

      t.timestamps
    end
  end
end
