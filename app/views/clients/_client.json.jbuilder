json.extract! client, :id, :email, :name, :surname, :rut, :address, :phone, :created_at, :updated_at
json.url client_url(client, format: :json)
