class QuotePdf < BasePdf
  def initialize(order, view)
    super(order,view)
    top
    client_data
    car_data
    conditions
    ending
    signatures
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

  end

end
