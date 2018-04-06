class SaleDecorator < ApplicationDecorator
  delegate_all
  decorates_finders

  def attributes
    %w(folio employee car list_price discount appraisal pva tax total_transfer client final_price).map { |key| [key, send(key)] }
  end

  def pretty_show
    super(title: h.t('sale.show.table_title'))
  end

  def show_cash_payments
    if model.cash_payments.count >0
      h.render partial: 'payments/cash_show', locals: {cash_payments: model.cash_payments}
    end
  end

  def show_check_payments
    if model.check_payments.count >0
      h.render partial: 'payments/check_show', locals: {check_payments: model.check_payments}
    end
  end

  def show_card_payments
    if model.card_payments.count >0
      h.render partial: 'payments/card_show', locals: { card_payments: model.card_payments }
    end
  end

  def show_financier_payments
    if model.financier_payments.count >0
      h.render partial: 'payments/financier_show', locals: { financier_payments: model.financier_payments }
    end
  end

  def vehicle_payments_show
    if model.vehicle_payments.count >0
      h.render partial: 'payments/vehicle_show', locals: { v_p: model.vehicle_payments }
    end
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

  def list_price
    object.car.nil? ? 0 : object.car.list_price
  end

  def payment_selector
    nil
  end



end
