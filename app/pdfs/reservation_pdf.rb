class ReservationPdf < BasePdf
  def initialize(reservation, view)
    super
    top
    client_data
    car_data
    payment_methods
    ending
    signatures
  end

  def ending
    start_new_page
    text "Devolucion de Reservas", align: :center, size: @size_of_font + 5
    move_down 20
    text "DEVOLUCION DE RESERVA:\n\nEN CASO QUE LA RESERVA SE DEJE SIN EFECTO POR VOLUNTAD DEL COMPRADOR, SERÁ DESCONTADO UN 40% SOBRE EL MONTO CANCELADO, A MODO DE PENALIZACIÓN E INDEMNIZACIÓN A FAVOR DE LA AUTOMOTORA.\n\nEN CASO QUE LA RESERVA SE TUVIERE QUE DEJAR SIN EFECTO POR CAUSAS AJENAS A LA VOLUNTAD DEL COMPRADOR, COMO POR EJEMPLO, RECHAZO DEL CRÉDITO, ÉSTA SERÁ DEVUELTA ÍNTEGRAMENTE AL COMPRADOR SIN MAYOR TRÁMITE.\n\nEN CUALQUIER  CASO, LOS MONTOS SERÁN RESTITUÍDOS MEDIANTE DEPÓSITO BANCARIO O TRANSFERENCIA ELECTRÓNICA EN UN PLAZO DE 5 DÍAS HÁBILES COMO TOPE."
    move_down 10
    text "Monto Pagado: #{@view.number_to_currency @order.paid_amount}", align: :center, size: @size_of_font + 5



  end

end
