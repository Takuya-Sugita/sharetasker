# == Schema Information
#
# Table name: likes
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :integer
#  user_id    :integer
#

class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user_id, {presence: true}
  validates :post_id, {presence: true}
end
