class SaleDecorator < ApplicationDecorator
  delegate_all
  decorates_finders

  def attributes
    %w(folio employee car list_price list_discount appraisal pva tax transfer_discount total_transfer client final_price).map { |key| [key, send(key)] }
  end

  def condensed_attributes
    %w(folio employee final_price created_at).map { |key| [key, send(key)] }
  end

  def pretty_show
    super(title: h.t('sale.show.table_title'))
  end

  def show_payments
    h.render partial: 'payments/payments', locals: { decorated: self}
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

  def show_vehicle_payments
    if model.vehicle_payments.count > 0
      h.render partial: 'payments/vehicle_show', locals: { v_p: model.vehicle_payments }
    end
  end

  def show_transfer_payments
    if model.transfer_payments.count > 0
      h.render partial: 'payments/transfer_show', locals: { transfer_payments: model.transfer_payments }
    end
  end

  def employee
    "#{object.employee.name} #{object.employee.surname}"
  end

  def car
    object.car.decorate.label
  end

  def car_object
    object.car
  end

  def client
    "#{object.client.name} #{object.client.surname}"
  end

  def created_at
    super.nil? ? nil : super.to_date
  end

  def final_price
    super.nil? ? '$0' : h.number_to_currency(super)
  end

  def appraisal
    super.nil? ? '$0' : h.number_to_currency(super)
  end

  def earnings
    super.nil? ? '$0' : h.number_to_currency(super)
  end

  def list_discount
    super.nil? ? '$0' : h.number_to_currency(super)
  end

  def pva
    super.nil? ? '$0' : h.number_to_currency(super)
  end

  def transfer_cost
    super.nil? ? '$0' : h.number_to_currency(super)
  end

  def tax
    super.nil? ? '$0' : h.number_to_currency(super)
  end

  def transfer_discount
    super.nil? ? '$0' : h.number_to_currency(super)
  end

  def buy_price
    super.nil? ? '$0' : h.number_to_currency(super)
  end

  def total_transfer
    temp = model.transfer_cost + model.tax
    h.number_to_currency(temp != 0 ? temp : 0)
  end

  def sale_price
    temp = (object.car.nil? ? 0 : object.car.list_price) - (object.transfer_discount.nil? ? 0 : object.transfer_discount)
    h.number_to_currency(temp)
  end

  def list_price
    object.car.nil? ? '$0' : h.number_to_currency(object.car.list_price)
  end

  def car_license
    object.car.nil? ? nil : object.car.license_plate
  end




end
