class CarsController < InheritedResources::Base
  before_action :authenticate_employee!
  def show
    @car = Car.find(params[:id]).decorate
  end

  def index
    cars = Car.all.available
    if params.key?(:branch_id)
      cars = cars.where({branch_id: params[:branch_id]})
    end
    @cars = cars.decorate
  end

  private

  def car_params
    params.require(:car).permit(:brand_id, :model, :license_plate, :year, :color,
                                :milage, :fuel_id, :transmission_id, :branch_id)
  end
end
