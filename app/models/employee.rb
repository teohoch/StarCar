class Employee < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable
  validates :rut, rut: true

  after_create :assign_default_role
  has_many :branches
  has_many :repairs

  def assign_default_role
    add_role(:employee) if roles.blank?
  end


end
