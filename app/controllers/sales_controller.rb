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
    p = sale_params.to_h
    p[:employee_id] = current_employee.id
    @sale = Sale.new(p)
    respond_to do |format|
      if @sale.save
        format.html { redirect_to @sale, notice: 'Venta Realizada con exito' }
        format.json { render :show, status: :created, location: @sale }
      else
        format.html { render :new }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def sale_params
    params.require(:sale).permit(:employee_id, :car_id, :client_id, :branch_id, :price)
  end
end
