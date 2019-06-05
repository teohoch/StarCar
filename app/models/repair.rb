class Repair < ApplicationRecord
  belongs_to :employee
  belongs_to :car
  before_destroy :prevent_destroy

  def car
    Car.unscoped { super }
  end

  def prevent_destroy
    if car.in_repairs?
      errors.add :base, "No se puede borrar una reparacion activa."
      throw(:abort)
    else
      true
    end
  end
end
