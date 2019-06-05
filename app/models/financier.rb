class Financier < ApplicationRecord
  acts_as_paranoid
  has_many :financier_payments
  has_many :vehicle_payments

end
