class Acquisition < ApplicationRecord
  belongs_to :employee
  belongs_to :car_provider
  has_one :car, as: :procedence

  attr_accessor :payment_selector

  has_many :cash_payments, as: :cash_payable
  has_many :card_payments, as: :card_payable
  has_many :check_payments, as: :check_payable
  has_many :financier_payments, as: :financier_payable
  has_many :vehicle_payments, as: :vehicle_payable
  has_many :transfer_payments, as: :transfer_payable

  accepts_nested_attributes_for  :cash_payments, allow_destroy: true
  accepts_nested_attributes_for  :card_payments, allow_destroy: true
  accepts_nested_attributes_for  :check_payments, allow_destroy: true
  accepts_nested_attributes_for  :financier_payments, allow_destroy: true
  accepts_nested_attributes_for  :vehicle_payments, allow_destroy: true
  accepts_nested_attributes_for  :transfer_payments, allow_destroy: true

  accepts_nested_attributes_for  :car

  def car
    Car.unscoped { super }
  end

  def car_provider
    CarProvider.unscoped { super }
  end

  def employee
    Employee.unscoped { super }
  end

end
