class Reservation < ApplicationRecord
  belongs_to :car
  belongs_to :client
  belongs_to :employee
  belongs_to :branch

  attr_accessor :rut
end
