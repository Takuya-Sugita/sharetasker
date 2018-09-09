class AddCommentImageToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :comment_image, :string
  end
end
