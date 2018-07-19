class Prescription < ApplicationRecord

  # relaciones
  belongs_to :doctor
  belongs_to :user

  # validaciones
  validates_numericality_of :user_id
  validates_numericality_of :doctor_id
  validates :descripcion, presence: true, length: { in: 5..80 }

  # scopes
  scope :prescription_doctor, ->(doctor) { where(doctor_id: doctor)}
  scope :prescription_user, ->(user) { where(user_id: user)}
  scope :ordenados, -> {order('created_at DESC')}


  def self.joins_prescription
    joins(:doctor).joins(:user)
  end
end
