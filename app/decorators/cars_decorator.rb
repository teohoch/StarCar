class CarsDecorator < ApplicationCollectionDecorator
  def presentable_attributes
    %w[brand model_safe list_price license_plate year color milage status]
  end

  def pretty_show
    super(title: h.t('car.show.table_title'))
  end
end
