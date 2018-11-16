class CarsController < InheritedResources::Base
  before_action :authenticate_employee!
  load_and_authorize_resource
  def show
    @car = Car.find(params[:id]).decorate
  end

  def index
    cars = Car.all.available
    cars = if current_employee.has_role? :administrator
             cars
           elsif current_employee.has_role? :external
             cars.external
           else
             cars.general
           end
    cars = cars.where(branch_id: params[:branch_id]) if params.key?(:branch_id)
    @cars = cars.decorate
  end

  private

  def car_params
    params.require(:car).permit(:brand_id, :model, :license_plate, :year, :color,
                                :milage, :fuel_id, :transmission_id, :branch_id, :external)
  end
end
