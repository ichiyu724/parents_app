class Vaccination < ApplicationRecord
    has_many :history, dependent: :destroy
    belongs_to :child, dependent: :destroy
end
