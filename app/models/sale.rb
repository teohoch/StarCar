class Sale < ApplicationRecord
  belongs_to :branch
  belongs_to :employee
  belongs_to :car
  belongs_to :client
  has_many :cash_payments, as: :cash_payable
  has_many :card_payments, as: :card_payable
  has_many :check_payments, as: :check_payable
  has_many :financier_payments, as: :financier_payable
  has_many :vehicle_payments, as: :vehicle_payable
  has_many :transfer_payments, as: :transfer_payable
  has_many :repairs, through: :car

  accepts_nested_attributes_for  :cash_payments, allow_destroy: true
  accepts_nested_attributes_for  :card_payments, allow_destroy: true
  accepts_nested_attributes_for  :check_payments, allow_destroy: true
  accepts_nested_attributes_for  :financier_payments, allow_destroy: true
  accepts_nested_attributes_for  :vehicle_payments, allow_destroy: true
  accepts_nested_attributes_for  :transfer_payments, allow_destroy: true

  validates :pva, :appraisal, :list_discount, presence: true
  validate :payments_suffice?
  attr_accessor :rut, :payment_selector


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


  def payments_suffice?
    suffice = !comment.blank?
    unless suffice
      total_paid = 0
      total_paid += card_payments.map(&:amount).reduce(0, :+)
      total_paid += cash_payments.map(&:amount).reduce(0, :+)
      total_paid += check_payments.map(&:amount).reduce(0, :+)
      total_paid += financier_payments.map(&:amount).reduce(0, :+)
      total_paid += transfer_payments.map(&:amount).reduce(0, :+)
      total_paid += vehicle_payments.map(&:final_value).reduce(0, :+)
      if total_paid < final_price
        errors.add(:base, 'Los pagos no cubren el costo total de venta. Si desea realizar la venta de igual manera, agregue un comentario.')
      else
        suffice = true
      end
    end
    suffice
  end

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

  def earnings
    buy_price = car.buy_price
    costs = 0
    car.repairs.each do |repair|
      costs = costs + (repair.quote.nil? ? 0 : repair.quote)
    end
    car.costs.each do |cost|
      costs = costs + (cost.amount.nil? ? 0 : cost.amount)
    end
    final_price - costs - buy_price
  end

  private

  def calculate
    list_discount ||= 0
    transfer_discount ||= 0
    unless car.nil? || transfer_discount.nil? || pva.nil? || appraisal.nil? || list_discount.nil?
      sale_price = car.list_price - list_discount
      self.tax = [sale_price, pva, appraisal].max * 0.015
      self.transfer_cost = TRANSFER_COST
      self.buy_price = car.buy_price
      self.list_price = car.list_price
      self.earnings = sale_price - car.buy_price
      self.final_price = sale_price + tax + transfer_cost - transfer_discount
    end
  end
end
