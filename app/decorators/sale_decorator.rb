class SaleDecorator < ApplicationDecorator
  delegate_all
  decorates_finders

  def attributes
    %w(employee car client price).map { |key| [key, send(key)] }
  end

  def pretty_show
    super(title: h.t('sale.show.table_title'))
  end

  def employee
    "#{object.employee.name} #{object.employee.surname}"
  end

  def car
    object.car.decorate.label
  end

  def client
    "#{object.client.name} #{object.client.surname}"
  end



end
