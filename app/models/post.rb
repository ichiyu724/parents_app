class Post < ApplicationRecord
    belongs_to :user, optional: true
    has_many :favorites, dependent: :destroy
    has_many :comments, dependent: :destroy

    mount_uploader :content_image, ImageUploader

    validates :title, presence: true
    validates :content, presence: true
end
