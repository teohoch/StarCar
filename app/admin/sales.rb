ActiveAdmin.register Sale do
  menu label: "Ver Ventas"
  decorate_with SaleDecorator
  actions :index, :show

  config.xls_builder.delete_columns :id, :created_at, :updated_at
  index do
    selectable_column
    column :folio
    column :branch
    column :employee
    column :car do |sale|
      link_to(sale.car, admin_car_path(sale.car_object) )
    end
    column :client
    column :final_price
    column :earnings
    actions
  end


  show do
    attributes_table do
      row :branch
      row :employee
      row :car do |sale|
        link_to(sale.car, admin_car_path(sale.car_object) )
      end
      row :client
      row :appraisal
      row :tax
      row :transfer_cost
      row :transfer_discount
      row :list_discount
      row :pva
      row :list_price
      row :buy_price
      row :final_price
      row :earnings
      row :comment
      row :created_at
      row :updated_at


    end

    text_node '&nbsp;'.html_safe
    h3 'Reparaciones'

    table_for sale.repairs do
      column :created_at do |repairs|
        l repairs.created_at, format: :short
      end
      column :workshop
      column :reason
      column :quote do |repair|
        number_to_currency(repair.quote)
      end
    end
    text_node sale.show_payments.html_safe
  end
end
