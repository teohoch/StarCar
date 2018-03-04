class CarDecorator < ApplicationDecorator
  delegate_all
  decorates_finders

  def attributes
    %w(brand model_safe license_plate year color milage).map { |key| [key, send(key)] }
  end

  def pretty_show
    super(title: h.t('car.show.table_title'))
  end

  def model_safe
    object.model
  end

  def brand
    object.brand.name
  end
end
