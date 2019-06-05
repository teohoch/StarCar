class Branch < ApplicationRecord
  belongs_to :manager, :class_name => 'Employee'
  acts_as_paranoid

  has_many :cars
  has_many :reservations
  has_many :quotes

  def manager
    Employee.unscoped { super }
  end
end
