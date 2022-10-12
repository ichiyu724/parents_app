class Vaccination < ApplicationRecord
    has_many :histories, dependent: :destroy
end
