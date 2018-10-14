class Client < ApplicationRecord
  has_many :quotes
  validates :rut, rut: true

  def rut=(value)
    temp = value.split(//)
    validator = temp.pop
    numbers = temp.join
    super([numbers, validator].join('-'))
  end
end
