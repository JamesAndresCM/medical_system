class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #callback para que se inserte el id del user al crearse en la tabla role
  before_create :set_default_role
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true, uniqueness: true, length:  {in: 3..12}
  validates :email, presence: true, uniqueness: true
  #validates :avatar, presence: true
  #validates :cover, presence: true

  has_many :posts, dependent: :destroy
  has_many :comments

  #un usuario puede tener un solo rol
  has_one :role

  #validaciones para cover y avatar
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  has_attached_file :cover, styles: {  medium: "660x300>", thumb: "400x100>" }, default_url: "/images/:style/missing_cover.png"
  validates_attachment_content_type :cover, content_type: /\Aimage\/.*\z/


 #se inserta el id del usuario al ser este creado
  private
  def set_default_role
    self.role ||= Role.create()
  end
end
