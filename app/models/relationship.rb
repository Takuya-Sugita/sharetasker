# == Schema Information
#
# Table name: relationships
#
#  id           :integer          not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  follower_id  :integer
#  following_id :integer
#

class Relationship < ApplicationRecord

  belongs_to :following, class_name: "User"
  belongs_to :follower, class_name: "User"

  validates :follower_id, {presence: true}
  validates :following_id, {presence: true}

end
