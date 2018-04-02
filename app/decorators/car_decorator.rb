class CarDecorator < ApplicationDecorator
  delegate_all
  decorates_finders

  def attributes
    %w(brand model_safe license_plate year color milage).map { |key| [key, send(key)] }
  end

  def pretty_show
    super(title: h.t('car.show.table_title'))
  end

  def label
    "#{brand} #{model_safe} Patente: #{license_plate}"
  end

  def model_safe
    object.model.capitalize
  end

  def brand
    object.brand.name.capitalize
  end

  def year
    super.nil? ? '' : super
  end
end
