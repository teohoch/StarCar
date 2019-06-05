class VehiclePayment < ApplicationRecord
  belongs_to :vehicle_payable, polymorphic: true, optional: true
  has_one :car, as: :procedence
  belongs_to :financier, optional: true
  accepts_nested_attributes_for :car

  attr_writer :brand_id, :model, :year, :license_plate, :color, :milage, :fuel_id, :transmission_id
  attr_accessor :branch_id

  validates :prepaid, presence: true, if: :was_prepaid?
  validates :financier_id, presence: true, if: :was_prepaid?
  validate :year_is_integer
  validate :milage_is_integer
  validate :fuel_id_is_integer
  validate :transmision_is_integer
  validate :brand_id_is_integer
  validate :license_plate_formated
  validates :model, presence: true
  validates :color, presence: true




  def amount
    super.nil? ? 0 : super
  end

  def safe_prepaid
    self.prepaid.nil? ? 0 : self.prepaid
  end

  def brand_id
    if car.nil?
      @brand_id.nil? ? nil : @brand_id
    else
      car.brand_id
    end
  end

  def model
    if car.nil?
      @model.nil? ? nil : @model
    else
      car.model
    end
  end

  def year
    if car.nil?
      @year.nil? ? nil : @year
    else
      car.year
    end
  end

  def license_plate
    if car.nil?
      @license_plate.nil? ? nil : @license_plate
    else
      car.license_plate
    end
  end

  def color
    if car.nil?
      @color.nil? ? nil : @color
    else
      car.color
    end
  end

  def milage
    if car.nil?
      @milage.nil? ? nil : @milage
    else
      car.milage
    end
  end

  def fuel_id
    if car.nil?
      @fuel_id.nil? ? nil : @fuel_id
    else
      car.fuel_id
    end
  end

  def transmission_id
    if car.nil?
      @transmission_id.nil? ? nil : @transmission_id
    else
      car.transmission_id
    end
  end

  def final_value
    was_prepaid? ? amount - safe_prepaid : amount
  end

  def car
    Car.unscoped { super }
  end



  def was_prepaid?
    not (prepaid.blank? &&  financier.blank?)
  end

  def year_is_integer
    errors.add(:year, 'Debe ser un numero') unless @year.number?
  end

  def milage_is_integer
    errors.add(:milage, 'Debe ser un numero') unless @milage.number?
  end

  def fuel_id_is_integer
    errors.add(:fuel_id, 'Debe ser un numero') unless @fuel_id.number?
  end

  def transmision_is_integer
    errors.add(:transmission_id, 'Debe ser un numero') unless @transmission_id.number?
  end

  def brand_id_is_integer
    errors.add(:branch_id, 'Debe ser un numero') unless @brand_id.number?
  end

  def license_plate_formated
    re = /[a-zA-Z]{2}[\w]{2}.[0-9]{2}/m
    errors.add(:license_plate, 'Debe ser formato AA-BB-88') unless re.match(@license_plate)
  end

  def save (*)

    ActiveRecord::Base.transaction do
      super
      provider = CarProvider.find_by_name('Clientes')
      Car.create!(brand_id: @brand_id, model: @model, year: @year, license_plate: @license_plate, color: @color,
                        milage: @milage, fuel_id: @fuel_id, transmission_id: @transmission_id, branch_id: @branch_id,
                        buy_price: amount, car_provider: provider, procedence: self)
    end

    true
  rescue Error => e
    # Handle exception that caused the transaction to fail
    # e.message and e.cause.message can be helpful
    errors.add(:base, e.message)

    false
  end
end
