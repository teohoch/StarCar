class SalesDecorator < ApplicationCollectionDecorator
  def presentable_attributes
    %w[folio employee car client final_price created_at]
  end



end
