class Client < ApplicationRecord
  validates :rut, rut: true
end
