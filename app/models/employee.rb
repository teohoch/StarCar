class Employee < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable
  validates :rut, rut: { message: 'No es un RUT valido' }
  mount_uploader :avatar, AvatarUploader

  acts_as_paranoid

  after_create :assign_default_role
  has_many :branches
  has_many :repairs
  has_many :quotes
  has_many :sales

  validates :name, :surname, :rut, :address, :phone, presence: true

  def assign_default_role
    add_role(:employee) if roles.blank?
  end

end
