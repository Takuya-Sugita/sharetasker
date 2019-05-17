# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  content    :text
#  limitday   :datetime
#  place      :text
#  post_image :string
#  title      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy

  mount_uploader :post_image, PostImageUploader


  validates :title, {presence: true, length: {maximum: 20}}
  validates :content, {presence: true, length: {maximum: 300}}
  validates :user_id, {presence: true}
  validates :limitday, {presence: true}
  validates :place, {presence: true}

  def user
    return User.find_by(id: self.user_id)
  end




end
