class Relationship < ApplicationRecord
    belongs_to :following, class_name: 'User'
    belongs_to :follower, class_name: 'User'

    validates :following_id, presence: true, uniqueness: { scope: :follower_id }
    validates :follower_id, presence: true
end
