class ChangeChildToString < ActiveRecord::Migration[6.1]
  def up
    change_column :posts, :child_sex, :string
    change_column :posts, :child_age_year, :string
    change_column :posts, :child_age_month, :string
  end

  def down
    change_column :posts, :child_sex, :integer
    change_column :posts, :child_age_year, :integer
    change_column :posts, :child_age_month, :integer
  end
end
