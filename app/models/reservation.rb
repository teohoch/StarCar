class Reservation < ApplicationRecord
  belongs_to :car
  belongs_to :client
  belongs_to :employee
  belongs_to :branch

  attr_accessor :rut

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
    self.car.reserve!
  end

end
