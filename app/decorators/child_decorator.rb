# frozen_string_literal: true

module ChildDecorator
  def age
    today = Time.zone.today
    this_years_birthday = Time.zone.local(today.year, birthdate.month, birthdate.day)
    age_year = today.year - birthdate.year
    age_month = today.month - birthdate.month
    age_day = today.day - birthdate.day
    if today < this_years_birthday
      age_year -= 1
    end

    if age_month < 0 
      age_month = age_month + 12
    elsif age_month == 0 && age_day < 0
      age_month = 11
    else
      age_month 
    end

    if age_day < 0
      age_month -= 1
    end
    "#{age_year}歳#{age_month}ヶ月" 
  end
end
