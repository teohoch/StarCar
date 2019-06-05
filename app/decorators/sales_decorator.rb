class SalesDecorator < ApplicationCollectionDecorator
  def presentable_attributes
    %w[car_license employee car client final_price created_at]
  end



end
