include ActionView::Helpers::NumberHelper
class Client < ApplicationRecord
  acts_as_paranoid
  has_many :quotes
  validates :rut, rut: { message: 'No es un RUT valido' }

  def rut=(value)
    super(Client.strip_and_separate_rut(value).join('-'))
  end



  def self.strip_and_separate_rut(rut)
    temp = rut.delete('.')
    temp = temp.delete('-')
    temp = temp.split(//)
    validator = temp.pop
    numbers = temp.join
    [numbers, validator]
  end
end
