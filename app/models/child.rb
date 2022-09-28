class Child < ApplicationRecord
  belongs_to :user
  
  validates :nickname, presence: true
  validates :birthdate, presence: true
end
