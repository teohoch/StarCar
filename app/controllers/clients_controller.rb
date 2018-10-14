class ClientsController < InheritedResources::Base
  skip_before_action :verify_authenticity_token, only: [:create]
  before_action :authenticate_employee!
  def index
    clients = Client.all
    if params.key?(:rut)
      temp = params[:rut].split(//)
      validator = temp.pop
      numbers = temp.join
      clients = clients.where(rut: ([numbers, validator].join('-')))
    end
    @clients = clients.decorate
  end

  def new
    @client = Client.new
    if params.key?(:partial)
      render 'new_modal', layout: false
    else
      render 'new'
    end
  end

  def create
    @client = Client.new(client_params)
    respond_to do |format|
      if @client.save
        format.html { redirect_to @client, notice: 'Match was successfully created.' }
        format.json { render :show, status: :created, location: @client }
      else
        helpers.flash_message(:error, @client.errors)
        format.html { render :new }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def client_params
    params.require(:client).permit(:email, :name, :surname, :rut, :address, :phone)
  end
end
