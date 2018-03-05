json.extract! car, :id, :label, :brand_id, :model_safe, :license_plate, :year, :color, :milage, :fuel_id, :transmission_id, :created_at, :updated_at
json.url car_url(car, format: :json)
