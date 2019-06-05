class CarsController < InheritedResources::Base
  before_action :authenticate_employee!
  load_and_authorize_resource
  def show
    @car = Car.find(params[:id]).decorate
  end

  def index
    cars = Car.all
    cars = if current_employee.has_role? :external
             cars.external
           else
             cars
           end
    cars = cars.where(branch_id: params[:branch_id]).available if params.key?(:branch_id)
    @cars = cars.decorate
  end

  private

  def car_params
    params.require(:car).permit(:brand_id, :model, :license_plate, :year, :color,
                                :milage, :fuel_id, :transmission_id, :branch_id, :external)
  end
end
