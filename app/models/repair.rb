class Repair < ApplicationRecord
  belongs_to :employee
  belongs_to :car

  def car
    Car.unscoped { super }
  end
end
