class SalesController < InheritedResources::Base

  private

    def sale_params
      params.require(:sale).permit(:employee_id, :car_id, :client_id, :branch_id, :price)
    end
end

