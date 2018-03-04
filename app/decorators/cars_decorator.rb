class CarsDecorator < ApplicationCollectionDecorator
  def presentable_attributes
    %w[brand model_safe license_plate year color milage]
  end

  def pretty_show
    super(title: h.t('car.show.table_title'))
  end
end
