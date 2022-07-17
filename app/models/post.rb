class Post < ApplicationRecord
    enum child_sex: { boy: 0, girl: 1}

    belongs_to :user, optional: true

    mount_uploader :content_image, ImageUploader
end
