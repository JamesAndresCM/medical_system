class User < ApplicationRecord
  # enum para tipo de usuario, user => "patient", admin => administrator
  enum role: [:user, :admin]

  # uploader avatar
  mount_uploader :avatar, AvatarUploader

  # remuevo registro devise
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  # validaciones
  validates :username, presence: true, uniqueness: true, length: { in: 3..12 },
                       format: { with: /\A[a-zA-Z ]+\z/, message: 'Solo letras' }
  validates :email, presence: true, uniqueness: true, format: {:with => Devise::email_regexp, message: 'Email no valido'}
  validates :last_name, presence: true, length: { in: 1..12 }, format: { with: /\A[a-zA-Z]+\z/, message: 'Solo letras' }
  validates :last_name_mother, presence: true, length: { in: 1..12 }, format: { with: /\A[a-zA-Z]+\z/, message: 'Solo letras' }
  validates :phone_number, presence: true, format: {with: /\A[9]\d{8}/, message: 'Solo 9 numeros'}
  validates_presence_of :role
  validates :rut, rut: true, uniqueness: true

  # relaciones
  has_many :appointments, dependent: :destroy
  has_many :doctors, through: :appointments

  has_many :prescriptions, dependent: :destroy
  has_many :doctors, through: :prescriptions

  has_one :medical_card, dependent: :destroy

  # ordeno registros
  scope :ordenados, -> { order('created_at DESC')}

  # valido tamaño imagen
  def avatar_size_validation
    errors[:avatar] << 'error tamaño debe ser menor a 500KB' if avatar.size > 0.5.megabytes
  end
end
