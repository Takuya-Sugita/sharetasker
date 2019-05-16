class AddDetailsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :back_image, :string
    add_column :users, :image_name, :string
  end
end
