class FinancierPayment < ApplicationRecord
  belongs_to :financier_payable, polymorphic: true, optional: true
  belongs_to :financier

  scope :in_favour, -> { where(financier_payable_type: [Reservation.name, Sale.name]) }

  include AASM
  enum status: {
      pending: 0,
      paid: 1
  }

  aasm column: :status, enum: true do
    state :pending, initial: true
    state :paid

    event :collect do
      transitions from: :pending, to: :paid
    end
  end

  def state
    I18n.t("support.payment_status.#{status}")
  end

  def amount
    super.nil? ? 0 : super
  end

  def down_payment
    super.nil? ? 0 : super
  end

  def financier
    Financier.unscoped { super }
  end

end
