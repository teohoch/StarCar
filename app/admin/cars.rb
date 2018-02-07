ActiveAdmin.register Car do
  permit_params :brand, :model, :license_plate, :year, :color, :milage, :maintenances, :fuel_type, :transmission, 
                :prepaid, :reservation_price, :state

  index do
    selectable_column
    column :Brand
    column :model
    column :license_plate
    column :year
    column :color
    column :milage
    column :maintenances
    column :Fuel
    column :Transmission
    column :prepaid
    column :reservation_price
    column :state
  end
  
  filter :brand
  filter :model
  filter :year

  form do |f|
    f.inputs do
      f.input :brand
      f.input :model
      f.input :license_plate
      f.input :year
      f.input :color
      f.input :milage
      f.input :maintenances
      f.input :fuel
      f.input :transmission
      f.input :prepaid
      f.input :reservation_price
    end
    f.actions
  end
end
