class SalesController < InheritedResources::Base
  def index
    @sales = Sale.all.decorate
  end

  def show
    @sale = Sale.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        pdf = PurchaseOrderPdf.new(@sale, view_context)
        send_data pdf.render, filename: "order_#{@purchase_order}.pdf",
                              type: 'application/pdf',
                              disposition: 'inline'
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
    params.require(:sale).permit(:employee_id, :car_id, :client_id, :branch_id,
                                 :price, :appraisal, :transfer_cost, :pva, :discount, :comment,
                                 cash_payments_attributes: [
                                     :amount, :deposit_number,:_destroy],
                                 check_payments_attributes: [
                                     :amount, :code, :number, :date, :bank, :_destroy],
                                 card_payments_attributes: [
                                     :amount, :card_number, :type, :bank, :_destroy],
                                 financier_payments_attributes: [
                                     :amount, :financier_id, :discount, :down_payment, :_destroy],
                                 vehicle_payments_attributes: [
                                     :amount, :_destroy, :model, :brand_id, :license_plate, :year,
                                     :color, :buy_price, :transmission_id, :fuel_id, :milage, :branch_id]
    )
  end
end
