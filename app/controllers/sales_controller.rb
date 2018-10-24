class SalesController < InheritedResources::Base
  before_action :authenticate_employee!
  def index
    @sales = Sale.all.decorate
  end

  def show
    @sale = Sale.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        if params.has_key? :responsability
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
        @sale.car.sell!
        format.html { redirect_to @sale, notice: 'Venta Realizada con exito' }
        format.json { render :show, status: :created, location: @sale }
      else
        @sale = @sale.decorate
        flash_message(:error, @sale.errors.to_s)
        format.html { render :new }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    @sale = Sale.new.decorate
  end

  private

  def sale_params
    params.require(:sale).permit(:employee_id, :car_id, :client_id, :branch_id, :list_discount,
                                 :price, :appraisal, :transfer_cost, :pva, :transfer_discount, :comment,
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
