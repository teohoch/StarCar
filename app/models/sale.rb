class Sale < ApplicationRecord
  belongs_to :branch
  belongs_to :employee
  belongs_to :car
  belongs_to :client
  has_many :cash_payments
  has_many :card_payments
  has_many :check_payments
  has_many :financier_payments
  has_many :vehicle_payments
  has_many :transfer_payments

  accepts_nested_attributes_for  :cash_payments, allow_destroy: true
  accepts_nested_attributes_for  :card_payments, allow_destroy: true
  accepts_nested_attributes_for  :check_payments, allow_destroy: true
  accepts_nested_attributes_for  :financier_payments, allow_destroy: true
  accepts_nested_attributes_for  :vehicle_payments, allow_destroy: true
  accepts_nested_attributes_for  :transfer_payments, allow_destroy: true

  validates :pva, :appraisal, presence: true
  attr_accessor :rut

  TRANSFER_COST = 101_330

  def folio
    "N° %s%03d%03d" % [(self.created_at.year-2000), self.employee_id, self.id]
  end

  def display_name
    folio
  end

  def calculate_save
    calculate
    save
  end

  def calculate_save!
    calculate
    save!
  end

  def add_payment_car
    
  end

  private

  def calculate
    unless car.nil? || transfer_discount.nil? || pva.nil? || appraisal.nil? || list_discount.nil?
      sale_price = car.list_price - list_discount
      self.tax = [sale_price, pva, appraisal].max * 0.015
      self.transfer_cost = TRANSFER_COST
      self.buy_price = car.buy_price
      self.earnings = sale_price - car.buy_price
      self.final_price = sale_price + tax + transfer_cost - transfer_discount
    end
  end
end
