class QuotePdf < BasePdf
  def initialize(order, view)
    super(order,view)
    top
    client_data
    car_data
    conditions
    ending
    #page_numbering
  end

  def conditions
    requisitos = "• Pie desde un 20% dependiendo del perfil del cliente del valor del vehiculo \n• No tener protestos ni morosidades en el sistema comercial \n• Puedes financiar tu vehículo desde 12 a 48 cuotas \n• Contamos con producto renovación programada, 25 y 37 cuotas \n• Nuestras opciones financieras no aparecen en el sistema financiero"

    dependiente = "• Carnet de Identidad\n• Contrato Indefinido\n• Sueldo minimo $400.000\n• 3 Liquidaciones de Sueldo\n• 12 Cotizaciones de AFP\n• Comprobante de Domicilio"
    independiente = "• Carnet de Identidad del Dueño Empresa\n• Rut tributario de la empresa\n• Carpeta tributaria\n• Tener mínimo un DAI\n• Carpeta tributaria personal ( Dueño de la empresa)"
    stroke_horizontal_line 0, 540
    move_down 5
    text 'Requisitos para un Financiamiento Automotriz:', size: @size_of_font +1
    stroke_horizontal_line 0, 540
    move_down 5
    text requisitos
    move_down 5
    set = cursor
    stroke_horizontal_line 0, 540
    move_down 18
    stroke_horizontal_line 0, 540

    column_box([0, set-5], columns: 2, width: bounds.width, height: 100) do
      text 'Caso Dependiente:', size: @size_of_font +1
      move_down 5
      text dependiente

      text 'Caso Independiente:', size: @size_of_font +1
      move_down 5
      text independiente

    end


  end

  def ending
    move_down 20
    text "Precio Cotizacion: #{@view.number_to_currency @order.quote_price}", align: :center, size: @size_of_font + 4
    text "Costo Transferencia: #{@view.number_to_currency @order.transfer_cost}", align: :center, size: @size_of_font

    move_down 100/2
    stroke_horizontal_line 20, 200
    stroke_horizontal_line 360, 520
    move_down 5
    text_box("#{@order.employee.name} #{@order.employee.surname}", at: [20, cursor], width: 180, align: :center)
    text_box("#{@order.client.name} #{@order.client.surname}", at: [350, cursor], width: 180, align: :center)
    move_down 15
    text_box(@order.employee.rut.to_s, at: [20, cursor], width: 180, align: :center)
    text_box(@order.client.rut.to_s, at: [350, cursor], width: 180, align: :center)

    move_down 35
    stroke_horizontal_line 200, 360
    move_down 5
    text_box("#{@order.branch.manager.name} #{@order.branch.manager.surname}", at: [190, cursor], width: 180, align: :center)
    move_down 15
    text_box(@order.branch.manager.rut.to_s, at: [190, cursor], width: 180, align: :center)
  end

end
