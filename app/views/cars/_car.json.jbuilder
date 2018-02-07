json.extract! car, :id, :brand_id, :model, :license_plate, :year, :color, :milage, :maintenances, :FuelType_id, :Transmission_id, :prepaid, :created_at, :updated_at
json.url car_url(car, format: :json)
