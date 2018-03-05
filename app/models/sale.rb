class Sale < ApplicationRecord
  belongs_to :branch
  belongs_to :employee
  belongs_to :car
  belongs_to :client

  # attr_reader
  def rut
    self[:rut]
  end

  # attr_writer
  def rut=(val)
    self[:rut] = val
  end
end
