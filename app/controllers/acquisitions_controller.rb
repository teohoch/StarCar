class AcquisitionsController < InheritedResources::Base
  load_and_authorize_resource

  def new
    @acquisition = Acquisition.new
    @acquisition.build_car
  end

  def create
    @acquisition = Acquisition.new(acquisition_params)
    @acquisition.employee = current_employee
    @acquisition.car_provider_id = acquisition_params[:car_attributes][:car_provider_id]
    @acquisition.car.buy_price = acquisition_params[:amount_paid]
    begin
      ActiveRecord::Base.transaction do
        @acquisition.save!
        respond_to do |format|
          @acquisition = @acquisition.decorate
          format.html { redirect_to @acquisition, notice: 'Adquisición creada con exito.' }
          format.json { render :show, status: :created, location: @acquisition }
        end
      end
    rescue => e
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @acquisition.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def acquisition_params
    params.require(:acquisition).permit(:employee_id, :amount_paid, :car_provider_id,
                                        car_attributes: %i[
                                          brand_id model license_plate year color milage fuel_id transmission_id
                                          car_provider_id technical_review_expiration permit cc soap property branch_id
                                          external
                                        ],
                                        transfer_payments_attributes: %i[
                                          amount deposit_number deposit _destroy
                                        ],
                                        cash_payments_attributes: %i[
                                          amount deposit_number _destroy
                                        ],
                                        check_payments_attributes: %i[
                                          amount code number due_date date bank _destroy
                                        ],
                                        card_payments_attributes: %i[
                                          amount card_number card_type bank _destroy
                                        ],
                                        financier_payments_attributes: %i[
                                          amount financier_id transfer_discount down_payment _destroy
                                        ],
                                        vehicle_payments_attributes: %i[
                                          amount _destroy model brand_id license_plate year
                                          color buy_price transmission_id fuel_id milage branch_id
                                        ])
  end
end
