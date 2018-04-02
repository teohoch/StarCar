class Car < ApplicationRecord
  belongs_to :brand
  belongs_to :branch
  belongs_to :fuel, optional: true
  belongs_to :transmission, optional: true
  has_many :repairs
  has_many :sales
  has_many :vehicle_payments
  accepts_nested_attributes_for :repairs

  validates :license_plate, :buy_price, :model, presence: true

  include AASM
  enum state: {
      not_available: 0,
      available: 1,
      in_repairs: 2,
      sold: 3
  }

  scope :in_repairs, -> {where(state: 2)}
  scope :available, -> {where(state: 1)}
  scope :not_available, -> {where(state: 0)}
  def status
    I18n.t("support.car_states.#{state}")
  end

  def permit
    super.nil? ? super : "#{super.month}-#{super.year}"
  end

  def permit=(data)
    super("01-#{data}")
  end


  aasm column: :state, enum: true do
    state :not_available, initial: true
    state :available
    state :in_repairs
    state :sold

    event :send_for_repairs do
      transitions from: [:not_available, :available], to: :in_repairs
    end

    event :end_repairs do
      transitions from: :in_repairs, to: :not_available
    end


    event :publish do
      transitions from: :not_available, to: :available do
        guard do
         !list_price.nil? &&  !buy_price.nil?
        end
      end
    end
    event :sell do
      transitions from: :available, to: :sold
    end
  end

end
