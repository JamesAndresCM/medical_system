class MedicalCard < ApplicationRecord
  belongs_to :user

  has_many :medical_histories, dependent: :destroy
  has_many :doctors, through: :medical_histories

  validates :diagnostico_user, presence: true, length: { in: 5..20 },
            format: { with: /\A[a-zA-Z ]+\z/, message: 'Solo letras' }

  validates :ciudad, presence: true, length: { in: 2..20 },
            format: { with: /\A[a-zA-Z ]+\z/, message: 'Solo letras' }

  validates :edad, presence: true, numericality: true, length: { in: 1..3 }
  validates :peso, presence: true, numericality: true
  validates :estatura, presence: true, numericality: true

  validates :alergia, presence: true, length: { in: 2..20 },
            format: { with: /\A[a-zA-Z ]+\z/, message: 'Solo letras' }

end
