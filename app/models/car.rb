class Car < ApplicationRecord
  belongs_to :brand
  belongs_to :fuel
  belongs_to :transmission
end
