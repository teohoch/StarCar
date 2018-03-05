class PurchaseOrderPdf < Prawn::Document
  def initialize(order, view)
    super()
    @order = order
    @view = view
    logo
    page_numbering
  end

  def logo
    image_location = Rails.root.join('app','assets','images',"logoweb04invert.png").to_s
    image image_location, :position => :left, :vposition => :top, :height => 50
  end

  def order_number
    move_down 10
    text "Venta N°#{@order.id}", size: 30, style: :bold
    text_box "Fecha: " + (@order.SubmitDate ? @order.SubmitDate.strftime("%d/%m/%Y") : Date.current.to_s), size: 10, :align => :right, :vposition => :top
    stroke_horizontal_line 0, 540
  end

  def line_items
    move_down 20
    table line_item_rows do
      row(0).font_style = :bold
      columns(2..3).align = :center
      columns(0).align = :center
      self.row_colors = ["DDDDDD", "FFFFFF"]
      self.header = true
      self.width = 540
    end
  end

  def line_item_rows
    [["Cantidad", "Descripcion", "Precio", "Total"]] +
        @order.item_purchase_orders.map do |item|
          [item.amount, item.provider_article.to_label, price(item.container_price), price(item.total_price)]
        end
  end

  def price(num)
    @view.number_to_currency(num, precision: 0)
  end

  def total_price
    move_down 15
    text "Total.: #{price(@order.total_amount)}", size: 10, :align => :right
    text "19% I.V.A.: #{price(@order.total_amount * 0.19)}", size: 10, :align => :right
    text "Precio Total: #{price(@order.total_amount * 1.19)}", size: 16, style: :bold, :align => :right
  end

  def provider
    move_down 5
    data =[["Proveedor: \t", @order.provider.name],["RUT:", @order.provider.rut],["Telefono:", @order.provider.phone], ["Direccion:", @order.provider.address]]

    table data do
      row(0..3).columns(0..1).borders = []
      cells.padding = 2
    end

    stroke_horizontal_line 0, 540
  end

  def source
    move_down 5
    data = [["Emitida por: \t", @order.user.name], ["Direccion de Envio:", @order.send_location], ["Forma de Pago: ", @order.payment_method], ["Fecha de entrega:", (@order.sendDate ? @order.sendDate.strftime("%d/%m/%Y")  : "")]]

    table data do
      row(0..3).columns(0..1).borders = []
      cells.padding = 2
    end

    stroke_horizontal_line 0, 540
  end

  def page_numbering
    string = "Pagina <page> de <total>"

    options = { :at => [bounds.right - 150, 0],
                :width => 150,
                :align => :right}
    number_pages string, options
  end

end
