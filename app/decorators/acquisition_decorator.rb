class AcquisitionDecorator < ApplicationDecorator
  delegate_all
  decorates_finders

  def attributes
    %w(employee amount_paid car_provider).map { |key| [key, send(key)] }
  end

  def car_label
    object.car.decorate.label
  end

  def amount_paid
    h.number_to_currency super
  end

  def pretty_show(title=object.model_name.human, extra_values=[])
    super(title: title, extra_values: extra_values)
  end

  def employee
    "#{object.employee.name} #{object.employee.surname}"
  end

  def car_provider
    super.nil? ? '' : super.name
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
      h.render partial: 'payments/adquisition_check_show', locals: {check_payments: model.check_payments}
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

end
