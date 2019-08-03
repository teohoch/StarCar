# frozen_string_literal: true

class CheckPayment < ApplicationRecord
  acts_as_paranoid
  belongs_to :check_payable, polymorphic: true, optional: true
  before_destroy :check_if_destroyable

  scope :in_favour, -> { where(check_payable_type: [Reservation.name, Sale.name]) }
  scope :to_pay, -> { where(check_payable_type: Acquisition.name) }

  def folio
    format('%s%03d%04d', (created_at.year - 2000), check_payable_id, id).to_i
  end

  include AASM
  enum status: {
    pending: 0,
    paid: 1,
    acquitted: 2
  }

  aasm column: :status, enum: true do
    state :pending, initial: true
    state :paid
    state :acquitted

    event :collect do
      transitions from: :pending, to: :paid, guard: :collectable?
    end

    event :pay do
      transitions from: :pending, to: :acquitted
    end
  end

  def check_if_destroyable
    pending?
  end

  def state
    I18n.t("support.payment_status.#{status}")
  end

  def amount
    super.nil? ? 0 : super
  end

  def pay_adquisition
    pay! if may_pay? && (check_payable_type == Acquisition.name)
  end

  def collectable?
    check_payable_type != Acquisition.name
  end

  after_save(:pay_adquisition)
end
