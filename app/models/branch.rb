class Branch < ApplicationRecord
  belongs_to :manager, :class_name => 'Employee'
  has_many :cars
end
