class ReservationDecorator < ApplicationDecorator
  delegate_all
  decorates_finders

  def attributes
    %w(branch employee car client paid_amount).map { |key| [key, send(key)] }
  end

  def pretty_show
    super(title: h.t('reservation.show.table_title'))
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

  def client
    "#{object.client.name} #{object.client.surname}"
  end

  def branch
    "#{object.branch.title}"
  end

end
