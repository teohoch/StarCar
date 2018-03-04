json.extract! sale, :id, :employee_id, :car_id, :client_id, :price, :created_at, :updated_at
json.url sale_url(sale, format: :json)
