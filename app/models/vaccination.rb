class Vaccination < ApplicationRecord
    has_many :history, dependent: :destroy

    #VACCINATION_NAME = ['ヒブ', 'Ｂ型肝炎', 'ロタウイルス', '小児用肺炎球菌', '４種混合', '２種混合', 'BCG', '麻しん・風しん混合', '水痘', 'おたふくかぜ', '日本脳炎'].freeze
    #def vaccination_timing(birthday)
     # birthday = "2022-09-01"
     # JpVaccination.recommended_schedules(birthday)
    #end

end
