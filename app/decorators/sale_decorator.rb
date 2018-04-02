class SaleDecorator < ApplicationDecorator
  delegate_all
  decorates_finders

  def attributes
    %w(folio employee car client final_price).map { |key| [key, send(key)] }
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

  def created_at
    super.nil? ? nil : super.to_date
  end

  def final_price
    super.nil? ? nil : h.number_to_currency(super)
  end

  def folio
    "%s%03d%03d" % [(object.created_at.year-2000), object.employee_id, object.id]
  end

  def transfer_cost
    super.nil? ? 0 : super
  end

  def tax
    super.nil? ? 0 : super
  end

  def discount
    super.nil? ? 0 : super
  end

  def total_transfer
    transfer_cost + tax
  end

  def sale_price
    (object.car.nil? ? 0 : object.car.list_price) - (object.discount.nil? ? 0 : object.discount)
  end

  def payment_selector
    nil
  end



end
