class CarsController < InheritedResources::Base

  private

    def car_params
      params.require(:car).permit(:brand_id, :model, :license_plate, :year, :color,
                                  :milage, :maintenances, :FuelType_id, :Transmission_id, :prepaid)
    end
end

