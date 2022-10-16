class Child < ApplicationRecord
  belongs_to :user
  has_many :histories, dependent: :destroy
  
  validates :nickname, presence: true
  validates :birthdate, presence: true

  def pre_school_year(birthdate)
    fifth_birthday = birthdate + 5.years
    year =  case fifth_birthday.month
            when 1..3
              fifth_birthday.year
            when 4
              fifth_birthday.day == 1 ? fifth_birthday.year : fifth_birthday.year.next
            when 5..12
              sfifth_birthday.year.next
    end
    Date.new(year, 4, 1)..Date.new(year.next, 3, 31)
  end
end
