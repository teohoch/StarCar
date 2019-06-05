class EmployeeDecorator < Draper::Decorator
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
  def rut
    temp = super.split('-')
    validator = temp.pop
    numbers = temp.join
    [number_with_delimiter(numbers), validator].join('-')
  end

end
