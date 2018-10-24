class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[show edit update destroy]

  # GET /reservations
  # GET /reservations.json
  def index
    @reservations = Reservation.all.decorate
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show; end

  # GET /reservations/new
  def new
    @reservation = Reservation.new
  end

  # GET /reservations/1/edit
  def edit; end

  # POST /reservations
  # POST /reservations.json
  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.employee = current_employee
    begin
      ActiveRecord::Base.transaction do
        @reservation.reserve!
        respond_to do |format|
          format.html { redirect_to @reservation, notice: 'Reserva realizada con exito.' }
          format.json { render :show, status: :created, location: @reservation }
        end

      end
    rescue => e
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservations/1
  # PATCH/PUT /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to @reservation, notice: 'Reservation was successfully updated.' }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    @reservation.destroy
    respond_to do |format|
      format.html { redirect_to reservations_url, notice: 'Reservation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def reservation_params
    params.require(:reservation).permit(:rut, :branch_id, :car_id, :paid_amount, :client_id,
                                        transfer_payments_attributes: %i[
                                   amount deposit_number _destroy
                                 ],
                                        cash_payments_attributes: %i[
                                   amount deposit_number _destroy
                                 ],
                                        check_payments_attributes: %i[
                                   amount code number date bank _destroy
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
