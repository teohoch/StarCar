# frozen_string_literal: true

class SalesController < InheritedResources::Base
  before_action :authenticate_employee!
  load_and_authorize_resource
  def index
    @sales = (current_employee.has_role? :administrator) ? Sale.all.decorate : Sale.where(employee: current_employee).decorate
  end

  def show
    @sale = Sale.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        if params.key? :responsability
          pdf = ResponsabilityPdf.new(@sale, view_context)
          send_data pdf.render, filename: "carta_responsabilidad_#{@sale.folio}.pdf",
                                type: 'application/pdf',
                                disposition: 'inline'
        else
          pdf = SalePdf.new(@sale, view_context)
          send_data pdf.render, filename: "venta_#{@sale.folio}.pdf",
                                type: 'application/pdf',
                                disposition: 'inline'
        end
      end
    end
  end

  def create
    @sale = Sale.new(sale_params)
    @sale.employee = current_employee

    respond_to do |format|
      if @sale.calculate_save
        format.html { redirect_to @sale, notice: 'Venta Realizada con exito' }
        format.json { render :show, status: :created, location: @sale }
      else
        flash_message(:error, @sale.errors.messages.to_s)
        @client_rut = @sale.client.nil? ? nil : @sale.client.rut
        @car_id = @sale.car.nil? ? nil : @sale.car.id
        @branch_id = @sale.car.nil? ? nil : @sale.car.branch.id

        format.html { render :new }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    @sale = Sale.new

    if params.key?(:car_id) && Car.where(id: params[:car_id]).exists?
      car = Car.find(params[:car_id])
      @car_id = car.id
      @branch_id = car.branch.id
    end
    @client_rut = params[:rut] if params.key?(:rut) && Client.where(rut: params[:rut]).exists?
  end

  def destroy
    if params.key?(:recreate)
      recreated_sale = @sale.deep_clone include: [
        :cash_payments,
        :card_payments,
        :check_payments,
        :financier_payments,
        { vehicle_payments: :car },
        :transfer_payments
      ]
    end
    respond_to do |format|
      if @sale.destroy
        if params.key?(:recreate)
          @sale = recreated_sale
          @client_rut = @sale.client.nil? ? nil : @sale.client.rut
          @car_id = @sale.car.nil? ? nil : @sale.car.id
          @branch_id = @sale.car.nil? ? nil : @sale.car.branch.id
          @sale.car.sale_recreation!
          format.html { render :new, notice: "#{Sale.model_name.human} #{t('succesfully_destroyed')}" }
        else
          @sale.car.sale_nullification!
          format.html { redirect_to sales_url, notice: "#{Sale.model_name.human} #{t('succesfully_destroyed')}" }
        end

        format.json { head :no_content }
      else
        @sale.errors.messages.each do |error|
          flash_message(:error, error)
        end
        format.html do
          render(:show, status: :bad_request)
        end
        format.json { head :bad_request }
      end
    end
  end

  private

  def sale_params
    params.require(:sale).permit(:employee_id, :car_id, :client_id, :branch_id, :list_discount,
                                 :price, :appraisal, :transfer_cost, :pva, :transfer_discount, :comment,
                                 transfer_payments_attributes: %i[
                                   amount deposit _destroy
                                 ],
                                 cash_payments_attributes: %i[
                                   amount deposit_number _destroy
                                 ],
                                 check_payments_attributes: %i[
                                   amount code number date due_date bank _destroy
                                 ],
                                 card_payments_attributes: %i[
                                   amount card_number card_type bank _destroy
                                 ],
                                 financier_payments_attributes: %i[
                                   amount financier_id transfer_discount down_payment _destroy
                                 ],
                                 vehicle_payments_attributes: %i[
                                   amount _destroy model brand_id license_plate year
                                   color buy_price transmission_id fuel_id milage branch_id financier_id prepaid
                                 ])
  end
end
