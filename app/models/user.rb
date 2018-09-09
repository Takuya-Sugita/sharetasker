# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  back_image             :string
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string
#  image_name             :string
#  name                   :string
#  password_digest        :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

      has_secure_password

      has_many :likes
      has_many :posts
      has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
      has_many :followings, through: :active_relationships, source: :follower
      has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
      has_many :followers, through: :passive_relationships, source: :following

      validates :name, {presence: true, length:{maximum: 50}}
      validates :email, {presence: true, uniqueness:true}
      validates :password, {presence: true, allow_nil: true}

       def posts
        return Post.where(user_id: self.id)
       end

      def followed_by?(user)
        passive_relationships.find_by(following_id: user.id).present?
      end


end
