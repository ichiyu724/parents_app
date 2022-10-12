class History < ApplicationRecord
  belongs_to :child
  belongs_to :vaccination

  validates :date, presence: true 
end
