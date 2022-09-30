class Vaccination < ApplicationRecord
    has_many :history, dependent: :destroy
end
