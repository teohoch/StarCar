class BasePdf < Prawn::Document
  def initialize(object, view)
    @order = object
    @view = view
    @size_of_font = 11
    super(:page_size => "LEGAL", :font_size => @size_of_font)
    font 'Times-Roman'

    page_numbering
  end

  def top
    image_location = Rails.root.join('app', 'assets', 'images', 'logoweb04invert.png').to_s
    image image_location, position: :left, vposition: :top, height: 50
    text_box "Fecha\t\t\t\t\t\t:\t" + (@order.created_at ? @order.created_at.strftime('%d/%m/%Y') : Date.current.to_s), size: @size_of_font -1, at: [400, 920]
    text_box "Vendedor\t:\t#{@order.employee.name} #{@order.employee.surname}", size: 10, at: [400, 900]
    text_box "Sucursal\t\t:\t\t#{@order.branch.title}", size: 10, at: [400, 880]
    move_down 5
    text_box('Sociedad Comercial CAEF ltda.', at: [0, 880])
    text_box('76.192.322-6', at: [0, 865])

  end

  def client_data
    move_down 40
    stroke_horizontal_line 0, 540
    move_down 5
    text 'Datos de Cliente', size: @size_of_font + 1
    stroke_horizontal_line 0, 540
    move_down 5

    column_box([0, cursor], columns: 1, width: bounds.width, height: 65) do
      text("Nombre\t\t\t:\t#{@order.client.name} #{@order.client.surname}")
      text("RUT\t\t\t\t\t\t\t\t\t:\t#{@order.client.rut}")
      text("Direccion\t:\t#{@order.client.address}")
      text("Telefono\t\t:\t#{@order.client.phone}")
      text("Correo\t\t\t\t:\t#{@order.client.email}")
    end
  end

  def car_data
    move_down 10
    stroke_horizontal_line 0, 540
    move_down 5
    text 'Datos del Vehiculo', size: @size_of_font +1
    stroke_horizontal_line 0, 540
    move_down 5

    column_box([0, cursor], columns: 2, width: bounds.width, height: 50) do
      text("Patente: #{@order.car.license_plate}")
      text("Marca: #{@order.car.brand.name}")
      text("Año: #{@order.car.year}")

      text("Precio Lista: #{@view.number_to_currency @order.car.list_price}")
      text("Color: #{@order.car.color}")
      text("Modelo: #{@order.car.model}")
    end
  end

  def payment_methods
    move_down 10
    stroke_horizontal_line 0, 540
    move_down 5
    text 'Metodos de Pago', size: @size_of_font + 1
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
    payments = @order.cash_payments.map { |p| cash_payment(p) }
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

  def page_numbering
    string = 'Pagina <page> de <total>'

    options = { at: [bounds.right - 150, 0],
                width: 150,
                align: :right }
    number_pages string, options
  end
end
