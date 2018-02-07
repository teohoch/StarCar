FactoryBot.define do
  factory :car do
    brand nil
    model "MyString"
    license_plate "MyString"
    year 1
    color "MyString"
    milage 1.5
    maintenances 1
    Fuel nil
    Transmission nil
    prepaid "MyString"
  end
end
