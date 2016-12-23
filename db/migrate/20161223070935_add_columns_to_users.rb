class AddColumnsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :nickname, :string
    add_column :users, :profile_img, :string
  end
end
