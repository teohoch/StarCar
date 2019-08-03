# frozen_string_literal: true

class Sale < ApplicationRecord
  acts_as_paranoid
  belongs_to :branch, -> { with_deleted }
  belongs_to :employee, -> { with_deleted }
  belongs_to :car, -> { with_deleted }
  belongs_to :client, -> { with_deleted }

  has_many :cash_payments, as: :cash_payable, dependent: :destroy
  has_many :card_payments, as: :card_payable, dependent: :destroy
  has_many :check_payments, as: :check_payable, dependent: :destroy
  has_many :financier_payments, as: :financier_payable, dependent: :destroy
  has_many :vehicle_payments, as: :vehicle_payable
  has_many :transfer_payments, as: :transfer_payable, dependent: :destroy

  has_many :repairs, through: :car

  before_destroy :destroy_subresources

  accepts_nested_attributes_for  :cash_payments, allow_destroy: true
  accepts_nested_attributes_for  :card_payments, allow_destroy: true
  accepts_nested_attributes_for  :check_payments, allow_destroy: true
  accepts_nested_attributes_for  :financier_payments, allow_destroy: true
  accepts_nested_attributes_for  :vehicle_payments, allow_destroy: true
  accepts_nested_attributes_for  :transfer_payments, allow_destroy: true

  validates :pva, :appraisal, :list_discount, presence: true
  validate :payments_suffice?
  attr_accessor :rut, :payment_selector

  TRANSFER_COST = 107_540

  def folio
    format('N° %s%03d%03d', (created_at.year - 2000), employee_id, id)
  end

  def display_name
    folio
  end

  def calculate_save
    ActiveRecord::Base.transaction do
      calculate
      car.sell!
      save!
      true
    end
  rescue StandardError
    false
  end

  def calculate_save!
    calculate
    car.sell!
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

  def earnings
    buy_price = car.buy_price
    costs = 0
    car.repairs.each do |repair|
      costs += (repair.quote.nil? ? 0 : repair.quote)
    end
    car.costs.each do |cost|
      costs += (cost.amount.nil? ? 0 : cost.amount)
    end
    final_price - costs - buy_price
  end

  private

  def calculate
    self.list_discount ||= 0
    self.transfer_discount ||= 0
    unless car.nil? || self.transfer_discount.nil? || pva.nil? || appraisal.nil? || self.list_discount.nil?
      sale_price = car.list_price - self.list_discount
      self.tax = [sale_price, pva, appraisal].max * 0.015
      self.transfer_cost = TRANSFER_COST
      self.buy_price = car.buy_price
      self.list_price = car.list_price
      self.final_price = sale_price + tax + transfer_cost - self.transfer_discount
    end
  end

  def destroy_subresources
    ActiveRecord::Base.transaction do
      cash_payments.destroy_all
      card_payments.destroy_all
      check_payments.destroy_all
      financier_payments.destroy_all
      vehicle_payments.destroy_all
      transfer_payments.destroy_all
    end
  rescue ActiveRecord::RecordNotDestroyed => e
    errors.add(:base,
               'La venta no puede ser anulada puesto que no se pueden anular el pago' \
                   " #{e.record.model_name.human}: ID ##{e.record.id}.")
    throw :abort
  end
end
