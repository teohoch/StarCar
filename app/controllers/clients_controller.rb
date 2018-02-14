class ClientsController < InheritedResources::Base

  private

    def client_params
      params.require(:client).permit(:email, :name, :surname, :rut, :address, :phone)
    end
end

