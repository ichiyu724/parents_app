class AddColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :username, :string
    add_column :users, :profile, :text
    add_column :users, :icon_image, :string
    add_column :users, :icon_image_id, :string
  end
end
