class ReservationPdf < Prawn::Document
  def initialize(reservation, view)
    super()
    @order = reservation
    @view = view
    top
    client_data
    car_data
    payment_methods
    ending
    page_numbering
  end

  def top
    image_location = Rails.root.join('app', 'assets', 'images', 'logoweb04invert.png').to_s
    image image_location, position: :left, vposition: :top, height: 50
    text_box "Fecha\t\t\t\t\t\t:\t" + (@order.created_at ? @order.created_at.strftime('%d/%m/%Y') : Date.current.to_s), size: 10, at: [350, 720]
    text_box "Vendedor\t:\t#{@order.employee.name} #{@order.employee.surname}", size: 10, at: [350, 700]
    text_box "Sucursal\t\t:\t\t#{@order.branch.title}", size: 10, at: [350, 680]
    move_down 5
    text_box('Sociedad Comercial CAEF ltda.', at: [0, 660])
    text_box('76.182.322-6', at: [0, 645])

    text "Reserva", align: :center, size: 20
    # text_box("Nota Venta: #{@order.folio}", at: [250, 660])
  end

  def client_data
    move_down 40
    stroke_horizontal_line 0, 540
    move_down 5
    text 'Datos de Cliente', size: 15
    stroke_horizontal_line 0, 540
    move_down 5

    column_box([0, cursor], columns: 2, width: bounds.width, height: 30) do
      text("Nombre\t\t\t:\t#{@order.client.name} #{@order.client.surname}")
      text("RUT\t\t\t\t\t\t\t\t\t:\t#{@order.client.rut}")
      text("Direccion\t:\t#{@order.client.address}")
      text("Telefono\t\t:\t#{@order.client.phone}")
    end
  end

  def car_data
    move_down 10
    stroke_horizontal_line 0, 540
    move_down 5
    text 'Datos del Vehiculo', size: 15
    stroke_horizontal_line 0, 540
    move_down 5

    column_box([0, cursor], columns: 2, width: bounds.width, height: 50) do
      text("Patente: #{@order.car.license_plate}")
      text("Marca: #{@order.car.brand.name}")
      text("Año: #{@order.car.year}")


      text("Color: #{@order.car.color}")
      text("Modelo: #{@order.car.model}")

    end
  end

  def payment_methods
    move_down 10
    stroke_horizontal_line 0, 540
    move_down 5
    text 'Metodos de Pago', size: 15
    stroke_horizontal_line 0, 540
    move_down 5
    card_payments if @order.card_payments.count > 0
    cash_payments if @order.cash_payments.count > 0
    check_payments if @order.check_payments.count > 0
    transfer_payments if @order.transfer_payments.count > 0
    vehicle_payments if @order.vehicle_payments.count > 0
    financier_payments if @order.financier_payments.count > 0
  end

  def _pretty_payments(data, title)
    text title, style: :bold
    table data, cell_style: { border_width: [0, 0, 0, 0] }, position: 15
    move_down 5
  end

  def card_payment(payment)
    ["Banco: #{payment.bank}", "Tipo de Tarjeta: #{I18n.t "support.card_types.c#{payment.card_type}"}", "Monto: #{@view.number_to_currency payment.amount}"]
  end

  def card_payments
    payments = @order.card_payments.map { |p| card_payment(p) }
    _pretty_payments(payments, 'Pagos con Tarjeta')
  end

  def cash_payment(payment)
    ["Fecha: #{payment.created_at}", "Monto: #{@view.number_to_currency payment.amount}"]
  end

  def cash_payments
    payments = @order.card_payments.map { |p| cash_payment(p) }
    _pretty_payments(payments, 'Pagos con Efectivo')
  end

  def check_payment(payment)
    ["Banco: #{payment.bank}", "Codigo: #{payment.code}", "Monto: #{@view.number_to_currency payment.amount}"]
  end

  def check_payments
    payments = @order.check_payments.map { |p| check_payment(p) }
    _pretty_payments(payments, 'Pagos con Cheque')
  end

  def transfer_payment(payment)
    ["N° Deposito: #{payment.deposit}", "Monto: #{@view.number_to_currency payment.amount}"]
  end

  def transfer_payments
    payments = @order.transfer_payments.map { |p| transfer_payment(p) }
    _pretty_payments(payments, 'Pagos con Transferencia')
  end

  def vehicle_payment(payment)
    column_box([20, cursor], columns: 2, width: bounds.width, height: 45) do
      text("Patente: #{payment.car.license_plate}")
      text("Marca: #{payment.car.brand.name}")
      text("Modelo: #{payment.car.model}")
      text("Color: #{payment.car.color}")
      text("Año: #{payment.car.year}")
      text("Valor: #{@view.number_to_currency payment.amount}")
    end
  end

  def vehicle_payments
    count = @order.vehicle_payments.count
    string = count > 1 ? 'Vehiculos en parte de Pago' : 'Vehiculo en parte de Pago'
    text string, style: :bold
    @order.vehicle_payments.each_with_index do |p, index|
      vehicle_payment(p)
      if (count > 1) && (index < count - 1)
        stroke_horizontal_line 20, 480
        move_down 5
      end
    end
  end

  def financier_payment(payment)
    ["Financiera: #{payment.financier.name}", "Monto Financiado: #{@view.number_to_currency payment.amount}",
     "Pie: #{@view.number_to_currency payment.down_payment}",
     "Total: #{@view.number_to_currency payment.down_payment + payment.amount}"]
  end

  def financier_payments
    payments = @order.financier_payments.map { |p| financier_payment(p) }
    _pretty_payments(payments, 'Financiamiento')
  end

  def ending
    start_new_page
    text "Devolucion de Reservas", align: :center, size: 20
    move_down 20
    text "DEVOLUCION DE RESERVA:\n\nEN CASO QUE LA RESERVA SE DEJE SIN EFECTO POR VOLUNTAD DEL COMPRADOR, SERÁ DESCONTADO UN 40% SOBRE EL MONTO CANCELADO, A MODO DE PENALIZACIÓN E INDEMNIZACIÓN A FAVOR DE LA AUTOMOTORA.\n\nEN CASO QUE LA RESERVA SE TUVIERE QUE DEJAR SIN EFECTO POR CAUSAS AJENAS A LA VOLUNTAD DEL COMPRADOR, COMO POR EJEMPLO, RECHAZO DEL CRÉDITO, ÉSTA SERÁ DEVUELTA ÍNTEGRAMENTE AL COMPRADOR SIN MAYOR TRÁMITE.\n\nEN CUALQUIER  CASO, LOS MONTOS SERÁN RESTITUÍDOS MEDIANTE DEPÓSITO BANCARIO O TRANSFERENCIA ELECTRÓNICA EN UN PLAZO DE 5 DÍAS HÁBILES COMO TOPE."
    text "Monto Pagado: #{@view.number_to_currency @order.paid_amount}", align: :center, size: 20

    move_down 100
    stroke_horizontal_line 20, 200
    stroke_horizontal_line 360, 520
    move_down 5
    text_box("#{@order.employee.name} #{@order.employee.surname}", at: [20, cursor], width: 180, align: :center)
    text_box("#{@order.client.name} #{@order.client.surname}", at: [350, cursor], width: 180, align: :center)
    move_down 15
    text_box(@order.employee.rut.to_s, at: [20, cursor], width: 180, align: :center)
    text_box(@order.client.rut.to_s, at: [350, cursor], width: 180, align: :center)

    move_down 75
    stroke_horizontal_line 200, 360
    move_down 5
    text_box("#{@order.branch.manager.name} #{@order.branch.manager.surname}", at: [190, cursor], width: 180, align: :center)
    move_down 15
    text_box(@order.branch.manager.rut.to_s, at: [190, cursor], width: 180, align: :center)
  end

  def page_numbering
    string = 'Pagina <page> de <total>'

    options = { at: [bounds.right - 150, 0],
                width: 150,
                align: :right }
    number_pages string, options
  end
end
