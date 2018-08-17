class Specialty < ApplicationRecord
  has_one :doctor, dependent: :nullify

  validates :name, uniqueness: true, presence: true, length: { in: 5..20 },
            format: { with: /\A[a-zA-Z ]+\z/, message: 'Solo letras' }
end
