# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  admin                  :boolean          default(FALSE)
#  back_image             :string
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  image_name             :string
#  name                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  unconfirmed_email      :string
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

      attr_accessor :login

      has_many :likes, dependent: :destroy
      has_many :liked_posts, through: :likes, source: :post
      has_many :posts, dependent: :destroy
      has_many :comments, dependent: :destroy
      has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
      has_many :followings, through: :active_relationships, source: :follower
      has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
      has_many :followers, through: :passive_relationships, source: :following

      validates :name, {presence: true, length:{maximum: 50}}
      validates :email, {presence: true, uniqueness:true}
      validates :password, {presence: true, allow_nil: true}

      mount_uploader :image_name, UserImageUploader
      mount_uploader :back_image, BackImageUploader


       def posts
        return Post.where(user_id: self.id)
       end

      def followed_by?(user)
        passive_relationships.find_by(following_id: user.id).present?
      end

      def already_liked?(post)
        self.likes.exists?(post_id: post.id)
      end

end
