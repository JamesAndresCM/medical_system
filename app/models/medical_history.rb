class MedicalHistory < ApplicationRecord
  belongs_to :medical_card
  belongs_to :doctor

  scope :ordenados, -> { order('created_at desc') }
  validates :body, presence: true, length: { in: 10..250 }
end
