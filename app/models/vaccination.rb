class Vaccination < ApplicationRecord
    has_many :histories, dependent: :destroy
    belongs_to :child, dependent: :destroy
end
