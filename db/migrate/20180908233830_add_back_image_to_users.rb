class AddBackImageToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :back_image, :string
  end
end
