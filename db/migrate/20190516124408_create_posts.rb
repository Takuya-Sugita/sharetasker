class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.text :title
      t.text :content
      t.integer :user_id
      t.text :place
      t.datetime :limitday

      t.timestamps
    end
  end
end
