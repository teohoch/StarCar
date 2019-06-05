class Quote < ApplicationRecord
  belongs_to :car
  belongs_to :client
  belongs_to :employee
  belongs_to :branch

  attr_accessor :rut

  TRANSFER_COST = 101_330

  def branch
    Branch.unscoped { super }
  end

  def client
    Client.unscoped { super }
  end

  def employee
    Employee.unscoped { super }
  end

  def car
    Car.unscoped { super }
  end

  def transfer_cost
      TRANSFER_COST
  end
end
