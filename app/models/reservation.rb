class Reservation < ApplicationRecord
  belongs_to :car
  belongs_to :client
  belongs_to :employee
  belongs_to :branch

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


  attr_accessor :rut
  attr_accessor :payment_selector

  validates :paid_amount, presence: true
  validates :paid_amount, numericality: { greater_than: 0 }

  include AASM
  enum status: {
      instantiated: 0,
      created: 1,
      finalized: 2,
      cancelled: 3
  }

  aasm column: :status, enum: true, with_lock: true, whiny_persistence: true do
    state :instantiated, initial: true
    state :created
    state :finalized
    state :cancelled

    event :reserve do
      transitions from: :instantiated, to: :created, guard: :block_car
    end
  end

  def block_car
    self.save!
    self.car.reserve!
  end

end
