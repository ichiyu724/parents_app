class Child < ApplicationRecord
  belongs_to :user
  has_many :history
  
  validates :nickname, presence: true
  validates :birthdate, presence: true

  def vaccination_timing(birthday)
    birthday = "2022-09-01"
    JpVaccination.recommended_days(birthday, convert_to_strings = true)
  end
end
