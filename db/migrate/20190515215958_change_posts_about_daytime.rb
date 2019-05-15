class ChangePostsAboutDaytime < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :limitday, :datetime
    remove_column :posts, :limit, :text
  end
end
