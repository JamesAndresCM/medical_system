class Doctor < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, DoctorAvatarUploader

  scope :ordenados, -> {order(created_at: :desc)}

  validates :username, presence: true, uniqueness: true, length: { in: 3..12 },
            format: { with: /\A[a-zA-Z ]+\z/, message: 'Solo letras' }
  validates :email, presence: true, uniqueness: true, format: {:with => Devise::email_regexp, message: 'Email no valido'}
  validates :last_name, presence: true, length: { in: 1..12 }, format: { with: /\A[a-zA-Z]+\z/, message: 'Apellido Solo letras' }
  validates :last_name_mother, presence: true, length: { in: 1..12 }, format: { with: /\A[a-zA-Z]+\z/, message: 'Solo letras' }
  validates :phone_number, presence: true, format: {with: /\A[9]\d{8}/, message: 'Solo 9 numeros'}
  validates_presence_of :specialty_id
  validates :rut, rut: true, uniqueness: true

  has_many :appointments, dependent: :destroy
  has_many :users, through: :appointments

  has_many :prescriptions, dependent: :destroy
  has_many :users, through: :prescriptions

  belongs_to :specialty

  has_many :medical_histories, dependent: :destroy
  has_many :medical_cards, through: :medical_histories

  has_many :time_slots, dependent: :destroy

  def self.specialty_doctor(specialty)
    where(specialty_id: specialty).select(:id, :username, :last_name,
                                          :last_name_mother)
  end

  def self.available_doctor(doctor_id, slot_date)
    find_by(id: doctor_id).time_slots.where(time_slot_date: slot_date,
                                            availability: true)
                          .select(:id, :start_time, :end_time)
  end

  def avatar_size_validation
    errors[:avatar] << 'error tamaño debe ser menor a 500KB' if avatar.size > 0.5.megabytes
  end
end
