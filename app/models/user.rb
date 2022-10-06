class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  mount_uploader :icon_image, ImageUploader

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.username = "guest"
    end
  end

  has_many :posts
  has_many :favorites, dependent: :destroy
  has_many :comments
  has_many :children

  validates :username, presence: true, length: { maximum: 12 }

  has_many :relationships, foreign_key: :following_id
  has_many :followings, through: :relationships, source: :follower

  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: :follower_id
  has_many :followers, through: :reverse_of_relationships, source: :following

  def follow(user_id)
    relationships.create(follower_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(follower_id: user_id).destroy
  end

  def is_followed_by?(user)
    reverse_of_relationships.find_by(following_id: user.id).present?
  end
end
