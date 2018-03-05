class SalesDecorator < ApplicationCollectionDecorator
  def presentable_attributes
    %w[employee car client price]
  end



end
