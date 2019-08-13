class ResponsabilityPdf < Prawn::Document
  def initialize(order, view)
    @size_of_font = 11
    super(:page_size => "LEGAL", :font_size => @size_of_font)
    font 'Times-Roman'
    @order = order
    @view = view
    top
    naming
    car_specification
    legal
    ending
  end

  def top
    image_location = Rails.root.join('app', 'assets', 'images', 'logoweb04invert.png').to_s
    image image_location, position: :left, vposition: :top, height: 50
    text_box 'Carta de Responsabilidad', at: [0, 880], size: 20, align: :center
    move_down 10
  end

  def naming
    move_down 25
    string = "En #{@order.branch.title} a #{@order.created_at} entre don " \
             "#{@order.employee.name.upcase} #{@order.employee.surname.upcase} administrativo, en representación de " \
             "'SOCIEDAD COMERCIAL CAEF LIMITADA', RUT 76.192.322-6  con domicilio en " \
             "#{@order.branch.location}, en adelante EL VENDEDOR y " \
             "don #{@order.client.name.upcase} #{@order.client.surname.upcase} cédula de identidad número " \
             "#{@order.client.rut} domiciliado en #{@order.client.address.upcase} en adelante EL COMPRADOR," \
             ' ambos mayores de edad, y exponen:'
    text string, align: :justify
  end

  def car_specification
    move_down 10
    text 'PRIMERO: El COMPRADOR declara haber celebrado con esta misma fecha, un contrato de compraventa' \
         'con el VENDEDOR, consistente en el siguiente vehículo usado:',
         align: :justify
    data = [
      ['MARCA', @order.car.brand.name],
      ['MODELO', @order.car.model],
      ['AÑO', @order.car.year],
      ['PATENTE', @order.car.license_plate]
    ]
    table data, cell_style: { border_width: [0, 0, 0, 0] }, position: 200
    text "En el establecimiento comercial propiedad del vendedor, sucursal #{@order.branch.title.upcase}."
  end

  def legal
    segundo = 'SEGUNDO: El COMPRADOR declara en este acto haber probado el vehículo usado antes individualizado minuciosamente quedando conforme tanto en su espacio interior, como tapiz, artefactos electronicos, y en su espacio exterior, quedando por cierto, total y absolutamente conforme con el estado mecánico de dicho vehículo, y entendiendo que éste es de segunda mano, no tiene ningun reclamo ulterior que indicar, por ningún concepto en contra del VENDEDOR.'
    tercero = 'TERCERO: Que por este acto, el VENDEDOR declara que el vehículo vendido al COMPRADOR, y antes individualizado, se encuentra con los antecedentes reglares, éstos son, permiso de circulación, cert. de revisión técnica, seguro obligatorio, totalmente al día y y que han sido puestos en conocimiento del COMPRADOR, quien declara conformidad absoluta a su respecto sin reclamo ulterior que hacer en cuanto a los antecedentes o partes que pueda tener el vehículo.'
    cuarto = "CUARTO: Que habiéndose perfeccionado la compraventa del vehículo individualizado en la cláusula primera, el COMPRADOR declina o renuncia expresamente, la ejecución de cualquier acción legal y de cualquier índole o naturaleza que originó el contrato de compraventa del vehículo en comento, sin que ello implique una renuncia al dolo futuro, por o que el contrato de compraventa celebrado entre las partes, reúne todos y cada uno de los requisitos establecidos en los artículos 1.793, 1.808, 1.824 y siguientes del Código Civil, y a su vez de acuerdo a lo dispuesto en el artículo 1.839 del mismo cuerpo legal, el COMPRADOR y el VENDEDOR renuncian expresamente al saneamiento de la evicción, y entiéndase las presentes cláusulas como parte integrante del contrato de compraventa legalmente
celebrado entre éstas."
    final = "Previa lectura, y en comprobante, firman"
    move_down 15
    text segundo, align: :justify
    move_down 15
    text tercero, align: :justify
    move_down 15
    text cuarto, align: :justify
    move_down 15
    text final, align: :justify
  end

  def ending
    move_down 70
    stroke_horizontal_line 20, 200
    stroke_horizontal_line 360, 520
    move_down 5
    text_box("Sociedad Comercial CAEF ltda.\n 76.192.322-6", at: [20, cursor], width: 180, align: :center)
    text_box("#{@order.client.name} #{@order.client.surname} \n #{@order.client.rut.to_s}", at: [350, cursor], width: 180, align: :center)
    move_down 10


  end
end
