class Sale < ApplicationRecord
  belongs_to :employee
  belongs_to :car
  belongs_to :client
end
