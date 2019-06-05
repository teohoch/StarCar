# frozen_string_literal: true

class CarDecorator < ApplicationDecorator
  delegate_all
  decorates_finders

  def attributes
    %w[brand model_safe license_plate year color milage branch status].map { |key| [key, send(key)] }
  end

  def pretty_show(title = h.t('car.show.table_title'), extra_values = [])
    super(title: title, extra_values: extra_values)
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

  def branch
    super.nil? ? '' : super.title
  end

  def list_price
    super.nil? ? '' : h.number_to_currency(super)
  end

  def sale_checks
    object.sold? ? object.sales.map(&:check_payments).flatten : []
  end

  def procedence_checks
    (object.procedence_type == VehiclePayment.model_name.to_s) ? [] : object.procedence.check_payments
  end

  def reservation_check
    object.reserved? ? object.reservation.check_payments : []
  end

  def associated_checks
    procedence_checks + sale_checks + reservation_check
  end
end
