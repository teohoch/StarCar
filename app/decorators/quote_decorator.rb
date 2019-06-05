class QuoteDecorator < ApplicationDecorator
  delegate_all
  decorates_association :car

  def attributes
    %w(car employee branch client quote_price transfer_cost created_at).map { |key| [key, send(key)] }
  end

  def pretty_show
    super(title: h.t('quote.show.table_title'))
  end

  def employee
    "#{object.employee.name} #{object.employee.surname}"
  end

  def client
    "#{object.client.name} #{object.client.surname}"
  end

  def car
    object.car.decorate.label
  end

  def branch
    "#{object.branch.title} - #{object.branch.location}"
  end

  def quote_price
    h.number_to_currency(object.quote_price)
  end

  def transfer_cost
    h.number_to_currency(object.transfer_cost)
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
