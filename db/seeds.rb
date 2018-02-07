# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if Rails.env.development?
  Employee.create!(
    email: 'admin@example.com',
    password: 'password',
    password_confirmation: 'password',
    name: 'test',
    surname: 'tested',
    rut: '17995652-7',
    address: 'la luna',
    phone: 993830775
  )
end
