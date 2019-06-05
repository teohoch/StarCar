class Brand < ApplicationRecord
  has_many :cars
  acts_as_paranoid

end
