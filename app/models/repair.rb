class Repair < ApplicationRecord
  belongs_to :employee
  belongs_to :car
end
