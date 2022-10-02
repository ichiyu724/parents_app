class Child < ApplicationRecord
  belongs_to :user
  has_many :history
  
  validates :nickname, presence: true
  validates :birthdate, presence: true

  #def vaccination_schedule
   # jp_vaccination = JpVaccination.recommended_days(birthdate.to_s, convert_to_strings = true)
    #jp_vaccination[0][:date]
  #end
  
  #def vaccination_timing
   # vaccinnation_schedules = JpVaccination.recommended_days(birthdate.to_s, convert_to_strings = true)
    #vaccinnation_schedules.each do |values|
     # values[:date]
    #end
  #end

  def vaccination_schedule
    jp_vaccination = JpVaccination.recommended_schedules(birthdate.to_s, convert_to_strings = true)
    vaccines = jp_vaccination["2021-02-26"]
    vaccines.each do |vaccine|
      vaccine
    end
  end
end
