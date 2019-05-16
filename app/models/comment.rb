# == Schema Information
#
# Table name: comments
#
#  id            :integer          not null, primary key
#  comment       :text
#  comment_image :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  post_id       :integer
#  user_id       :integer
#

class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :comment, {presence: true, length:{maximum: 200}}
  validates :user_id, {presence: true}
  validates :post_id, {presence: true}
end
