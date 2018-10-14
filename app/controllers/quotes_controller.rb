class QuotesController < InheritedResources::Base

  before_action :set_quote, only: %i[show edit update destroy]

  # GET /quotes
  # GET /quotes.json
  def index
    @quotes = Quote.all.decorate
  end

  # GET /quotes/1
  # GET /quotes/1.json
  def show; end

  # GET /quotes/new
  def new
    @quote = Quote.new
  end

  # GET /quotes/1/edit
  def edit; end

  # POST /quotes
  # POST /quotes.json
  def create
    @quote = Quote.new(quote_params)
    @quote.employee = current_employee
    begin
      ActiveRecord::Base.transaction do
        @quote.reserve!
        respond_to do |format|
          format.html { redirect_to @quote, notice: 'Reserva realizada con exito.' }
          format.json { render :show, status: :created, location: @quote }
        end

      end
    rescue => e
      respond_to do |format|
        format.html { render :new }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quotes/1
  # PATCH/PUT /quotes/1.json
  def update
    respond_to do |format|
      if @quote.update(quote_params)
        format.html { redirect_to @quote, notice: 'Quote was successfully updated.' }
        format.json { render :show, status: :ok, location: @quote }
      else
        format.html { render :edit }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quotes/1
  # DELETE /quotes/1.json
  def destroy
    @quote.destroy
    respond_to do |format|
      format.html { redirect_to quotes_url, notice: 'Quote was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_quote
    @quote = Quote.find(params[:id])
  end
  
  
  private

  def quote_params
    params.require(:quote).permit(:car_id, :client_id, :employee_id, :branch_id, :quote_price)
  end
end
