class ReservationPdf < BasePdf
  def initialize(reservation, view)
    super
    top
    client_data
    car_data
    payment_methods
    ending
  end

  def ending
    start_new_page
    text "Devolucion de Reservas", align: :center, size: @size_of_font + 5
    move_down 20
    text "DEVOLUCION DE RESERVA:\n\nEN CASO QUE LA RESERVA SE DEJE SIN EFECTO POR VOLUNTAD DEL COMPRADOR, SERÁ DESCONTADO UN 40% SOBRE EL MONTO CANCELADO, A MODO DE PENALIZACIÓN E INDEMNIZACIÓN A FAVOR DE LA AUTOMOTORA.\n\nEN CASO QUE LA RESERVA SE TUVIERE QUE DEJAR SIN EFECTO POR CAUSAS AJENAS A LA VOLUNTAD DEL COMPRADOR, COMO POR EJEMPLO, RECHAZO DEL CRÉDITO, ÉSTA SERÁ DEVUELTA ÍNTEGRAMENTE AL COMPRADOR SIN MAYOR TRÁMITE.\n\nEN CUALQUIER  CASO, LOS MONTOS SERÁN RESTITUÍDOS MEDIANTE DEPÓSITO BANCARIO O TRANSFERENCIA ELECTRÓNICA EN UN PLAZO DE 5 DÍAS HÁBILES COMO TOPE."
    move_down 10
    text "Monto Pagado: #{@view.number_to_currency @order.paid_amount}", align: :center, size: @size_of_font + 5

    move_down 50
    stroke_horizontal_line 20, 200
    stroke_horizontal_line 360, 520
    move_down 5
    text_box("#{@order.employee.name} #{@order.employee.surname}", at: [20, cursor], width: 180, align: :center)
    text_box("#{@order.client.name} #{@order.client.surname}", at: [350, cursor], width: 180, align: :center)
    move_down 15
    text_box(@order.employee.rut.to_s, at: [20, cursor], width: 180, align: :center)
    text_box(@order.client.rut.to_s, at: [350, cursor], width: 180, align: :center)

    move_down 40
    stroke_horizontal_line 200, 360
    move_down 5
    text_box("#{@order.branch.manager.name} #{@order.branch.manager.surname}", at: [190, cursor], width: 180, align: :center)
    move_down 15
    text_box(@order.branch.manager.rut.to_s, at: [190, cursor], width: 180, align: :center)
  end

end
