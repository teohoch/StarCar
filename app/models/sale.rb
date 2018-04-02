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

  accepts_nested_attributes_for  :cash_payments
  accepts_nested_attributes_for  :card_payments
  accepts_nested_attributes_for  :check_payments
  accepts_nested_attributes_for  :financier_payments
  accepts_nested_attributes_for  :vehicle_payments

  validates :discount, :pva, :appraisal, presence: true

  TRANSFER_COST = 101_330

  # attr_reader
  def rut
    self[:rut]
  end

  # attr_writer
  def rut=(val)
    self[:rut] = val
  end

  def calculate_save
    calculate
    save
  end

  def calculate_save!
    calculate
    save!
  end

  private

  def calculate
    unless car.nil? || discount.nil? || pva.nil? || appraisal.nil?
      sale_price = car.list_price - discount
      self.tax = [sale_price, pva, appraisal].max * 0.015
      self.transfer_cost = TRANSFER_COST
      self.buy_price = car.buy_price
      self.earnings = sale_price - car.buy_price
      self.final_price = sale_price + tax + transfer_cost
    end
  end
end
