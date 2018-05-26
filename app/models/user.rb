class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #callback para que se inserte el id del user al crearse en la tabla role
  before_create :set_default_role
  mount_uploader :avatar, AvatarUploader
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true, uniqueness: true, length:  {in: 3..12}
  validates :email, presence: true, uniqueness: true
  #validates :avatar, presence: true
  #validates :cover, presence: true

  #un usuario puede tener un solo rol
  has_one :role, dependent: :destroy

 #se inserta el id del usuario al ser este creado
  private
  def set_default_role
    self.role ||= Role.create()
  end

  def avatar_size_validation
    errors[:avatar] << "should be less than 500KB" if avatar.size > 0.5.megabytes
  end
end
