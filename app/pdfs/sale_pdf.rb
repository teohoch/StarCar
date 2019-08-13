class SalePdf < BasePdf
  def initialize(order, view)
    super
    top
    client_data
    car_data
    payment_methods
    comments
    ending
  end

  def car_data
    move_down 10
    stroke_horizontal_line 0, 540
    move_down 5
    text 'Datos del Vehiculo', size: @size_of_font +1
    stroke_horizontal_line 0, 540
    move_down 5

    column_box([0, cursor], columns: 2, width: bounds.width, height: 100) do
      text("Patente: #{@order.car.license_plate}")
      text("Marca: #{@order.car.brand.name}")
      text("Año: #{@order.car.year}")
      text "\n"
      text("Precio Lista: #{@view.number_to_currency @order.car.list_price}")
      text("Descuento: #{@view.number_to_currency @order.list_discount}")
      text("Precio Venta Final: #{@view.number_to_currency @order.final_price}")

      text("Color: #{@order.car.color}")
      text("Modelo: #{@order.car.model}")
      text("Precio Venta: #{@view.number_to_currency (@order.car.list_price - @order.list_discount)}")
      text("Impuesto: #{@view.number_to_currency @order.tax}")
      text("Total: #{@view.number_to_currency (@order.tax + Sale::TRANSFER_COST)}")
      text("Descuento: #{@view.number_to_currency @order.transfer_discount}")
      text("Total Transferencia: #{@view.number_to_currency (@order.tax + Sale::TRANSFER_COST - @order.transfer_discount)}")
    end
  end

  def comments
    #start_new_page
    stroke_horizontal_line 0, 540
    move_down 5
    text 'Observaciones', size: @size_of_font +1
    stroke_horizontal_line 0, 540
    move_down 5
    text @order.comment
    move_down 15
    stroke_horizontal_line 0, 540
  end

  def ending
    move_down 20
    text "Precio Final Venta: #{@view.number_to_currency @order.final_price}", align: :center, size: @size_of_font + 4

    move_down 100/2
    signatures
  end

end
