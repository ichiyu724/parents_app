class Child < ApplicationRecord
  belongs_to :user
  has_many :history
  
  validates :nickname, presence: true
  validates :birthdate, presence: true

  VACCINATION_NAME = ['ヒブ', 'Ｂ型肝炎', 'ロタウイルス', '小児用肺炎球菌', '４種混合', '２種混合', 'BCG', '麻しん・風しん混合', '水痘', 'おたふくかぜ', '日本脳炎'].freeze
end
