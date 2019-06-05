class CheckPaymentDecorator < ApplicationDecorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
  #
  def display_name
    'N° ' + folio.to_s
  end

  def amount
    h.number_to_currency(object.amount)
  end

  def car
    object.check_payable.car
  end

end
