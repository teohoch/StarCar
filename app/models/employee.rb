class Employee < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable
  validates :rut, rut: true
  mount_uploader :avatar, AvatarUploader

  after_create :assign_default_role
  has_many :branches
  has_many :repairs
  has_many :quotes

  def assign_default_role
    add_role(:employee) if roles.blank?
  end


end
