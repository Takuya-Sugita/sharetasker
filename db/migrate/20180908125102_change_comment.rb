class ChangeComment < ActiveRecord::Migration[5.2]
  def change
    remove_column :comments, :posts_id, :integer
    add_column :comments, :post_id, :integer
  end
end
