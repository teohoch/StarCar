class AcquisitionsDecorator < ApplicationCollectionDecorator
  def presentable_attributes
    %w[employee car_label amount_paid car_provider]
  end



end
