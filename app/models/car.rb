# frozen_string_literal: true

class Car < ApplicationRecord
  belongs_to :brand
  belongs_to :branch
  belongs_to :fuel, optional: true
  belongs_to :transmission, optional: true
  belongs_to :car_provider
  belongs_to :procedence, polymorphic: true, optional: true

  has_many :repairs
  has_many :sales
  has_many :vehicle_payments
  has_many :quotes
  has_many :costs
  has_one  :reservation
  accepts_nested_attributes_for :repairs

  validates :license_plate, :buy_price, :model, presence: true
  validate :license_plate_formated

  before_destroy :check_if_destroyable

  acts_as_paranoid

  include AASM
  enum state: {
    not_available: 0,
    available: 1,
    in_repairs: 2,
    sold: 3,
    reserved: 4
  }

  scope :external, -> { where(external: true) }
  scope :general, -> { where(external: false) }

  def status
    I18n.t("support.car_states.#{state}")
  end

  def permit
    super.nil? ? super : "#{super.month}-#{super.year}"
  end

  def permit=(data)
    super("01-#{data}")
  end

  def label
    "#{brand.name} #{model} Patente: #{license_plate}"
  end

  def branch
    Branch.unscoped { super }
  end

  def sale
    sales.order('created_at DESC').first if sold?
  end

  def license_plate_formated
    re = /[a-zA-Z]{2}[\w]{2}.[0-9]{2}/m
    errors.add(:license_plate, 'Debe ser formato AABB.88') unless re.match(license_plate)
  end

  aasm column: :state, enum: true do
    state :not_available, initial: true
    state :available
    state :in_repairs
    state :sold
    state :reserved

    event :send_for_repairs do
      transitions from: %i[not_available available], to: :in_repairs
    end

    event :end_repairs do
      transitions from: :in_repairs, to: :not_available
    end

    event :reserve do
      transitions from: :available, to: :reserved
    end

    event :publish do
      transitions from: %i[not_available reserved], to: :available do
        guard do
          !list_price.nil? && !buy_price.nil?
        end
      end
    end
    event :sell do
      transitions from: :available, to: :sold
    end

    event :sale_recreation do
      transitions from: :sold, to: :available do
        guard do
          sales.count.zero?
        end
      end
    end

    event :sale_nullification do
      transitions from: :sold, to: :not_available do
        guard do
          sales.count.zero?
        end
      end
    end
  end

  private

  def check_if_destroyable
    unless available? || not_available?
      logger.info "\t\tVehicle ID: #{id} cannot be deleted because it's in use"
      errors.add(:base, "El vehiculo no puede ser borrado puesto que su estado es #{status}")
      throw :abort, 'El vehiculo no puede ser borrado'
    end
  end
end
