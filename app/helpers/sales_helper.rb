module SalesHelper
  PAYMENT_METHODS = %w[cash card check financier vehicle transfer].freeze
  def add_payment_method(name, f, element_id, hidden = false)
    field_list = []
    ids = []

    PAYMENT_METHODS.each do |method|
      temp = generate_fields(f, method + '_payments', 'payments/' + method + '_form')
      ids.push temp[0]
      field_list.push temp[1]
    end

    link_to(
      name, '#', class: 'add_fields btn btn-primary', data:
        {
          ids: ids,
          fields: field_list
        },
                 style: "display: #{hidden ? 'none' : 'visible'}; margin-left: 0px",
                 id: element_id,
                 'ng-click' => 'sc.add_payment_method($event)'

    )
  end

  def generate_fields(f, association, partial)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(partial, f: builder)
    end
    [id, fields.delete("\n").html_safe]
  end
end
