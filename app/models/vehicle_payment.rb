class VehiclePayment < ApplicationRecord
  belongs_to :sale
  belongs_to :car, optional: true
  accepts_nested_attributes_for :car
  attr_writer :brand_id, :model, :year, :license_plate, :color, :milage, :fuel_id, :transmission_id
  attr_accessor :branch_id

  def brand_id
    car.nil? ? nil : car.brand_id
  end

  def model
    car.nil? ? nil : car.model
  end

  def year
    car.nil? ? nil : car.year
  end

  def license_plate
    car.nil? ? nil : car.license_plate
  end

  def color
    car.nil? ? nil : car.color
  end

  def milage
    car.nil? ? nil : car.milage
  end

  def fuel_id
    car.nil? ? nil : car.fuel_id
  end

  def transmission_id
    car.nil? ? nil : car.transmission_id
  end

  def save (*)

    ActiveRecord::Base.transaction do
      car = Car.create!(brand_id: @brand_id, model: @model, year: @year, license_plate: @license_plate, color: @color,
                        milage: @milage, fuel_id: @fuel_id, transmission_id: @transmission_id, branch_id: @branch_id, buy_price: amount)
      VehiclePayment.create!(amount: amount, car: car, sale: sale)
    end

    true
  rescue Error => e
    # Handle exception that caused the transaction to fail
    # e.message and e.cause.message can be helpful
    errors.add(:base, e.message)

    false
  end
end
