ActiveAdmin.register Car do
  decorate_with CarDecorator
  menu priority: 7

  actions :all, except: [:create, :new]
  permit_params :brand_id, :model, :license_plate, :year, :color, :milage, :maintenances, :fuel_id,
                :transmission_id, :reservation_price, :state, :list_price, :buy_price, :technical_review_expiration,
                :book, :publication, :cc, :permit, :soap, :property, :branch_id, :car_provider_id,
                repair: %i[workshop reason quote]
  scope 'Todos', :all, default: true
  scope 'En Reparaciones', :in_repairs
  scope 'Disponibles', :available
  scope 'No Disponibles', :not_available
  scope 'Reservados', :reserved
  scope 'Vendidos', :sold

  config.xls_builder.delete_columns :id, :created_at, :updated_at

  index do
    selectable_column
    column :brand
    column :model
    column :license_plate
    column :year
    column :color
    column :milage do |car|
      "#{number_with_precision(car.milage, precision: 1, delimiter: ',')} KM"
    end
    column :maintenances
    column :fuel
    column :transmission
    column :buy_price do |car|
      number_to_currency(car.buy_price)
    end
    column :car_provider
    column :status
    column :branch
    column :external

    actions
  end

  sidebar "Asociados", only: [:show, :edit] do
    ul do
      li link_to "Costos", admin_car_costs_path(resource)
      li link_to "Reparaciones", admin_car_repairs_path(resource)
    end
  end

  show do

    attributes_table do
      row :brand
      row :model
      row :license_plate
      row :year
      row :color
      row :milage do |car|
        "#{number_with_precision(car.milage, precision: 1, delimiter: ',')} KM"
      end
      row :fuel
      row :transmission
      row :buy_price do |car|
        number_to_currency(car.buy_price)
      end
      row :car_provider
      row :soap
      row :permit
      row :technical_review_expiration
      row :status do |car|
        if car.state_before_type_cast == 3
          link_to(car.status, admin_sale_path(car.sales.first) )
        else
          car.status
        end
      end
      row :branch
      row :external
    end
    text_node '&nbsp;'.html_safe
    h3 'Reparaciones'
    table_for car.repairs do
      column :created_at do |repairs|
        l repairs.created_at, format: :short
      end
      column :workshop
      column :reason
      column :quote do |repair|
        number_to_currency(repair.quote)
      end
    end

    text_node '&nbsp;'.html_safe
    h3 'Costos'
    table_for car.costs do
      column :created_at do |cost|
        l cost.created_at, format: :short
      end
      column :amount do |cost|
        number_to_currency(cost.amount)
      end

    end


    text_node '&nbsp;'.html_safe
    h3 'Cheques Asociados'

    table_for car.associated_checks, i18n: CheckPayment do
      column :created_at do |check|
        l check.created_at, format: :short
      end
      column :amount do |check|
        number_to_currency(check.amount)
      end
      column :bank
      column :check_payable_type do |check|
        link_to check.check_payable.class.model_name.human, check.check_payable
      end
    end


  end

  filter :license_plate
  filter :brand
  filter :model
  filter :year
  filter :external

  form do |f|
    f.inputs do
      f.input :brand
      f.input :model
      f.input :license_plate
      f.input :year
      f.input :color, as: :string
      f.input :milage
      f.input :fuel
      f.input :transmission
      f.input :list_price
      f.input :buy_price
      f.input :car_provider
      f.input :technical_review_expiration, as: :datepicker
      f.input :book
      f.input :cc
      f.input :permit, as: :datepicker, datepicker_options:
          {
              changeMonth: true,
              changeYear: true,
              showButtonPanel: true,
              dateFormat: 'mm-yy'}

      f.input :soap
      f.input :property
      f.input :branch
      f.input :external
    end
    f.actions
  end

  member_action :showrepair, method: :get do
    @page_title = t('send_to_repairs')
    @repair ||= Repair.new
  end
  member_action :repair, method: :post
  member_action :end_repair, method: :get
  member_action :publish, method: :get

  action_item :repair, only: :show, if: proc { resource.may_send_for_repairs?  } do
    link_to 'Enviar a taller', showrepair_admin_car_path(car)
  end

  action_item :end_repair, only: :show, if: proc { resource.may_end_repairs?  } do
    link_to 'Finalizar reparacion', end_repair_admin_car_path(car)
  end

  action_item :publish, only: :show, if: proc { resource.may_publish?  } do
    link_to 'Poner a la Venta', publish_admin_car_path(car)
  end

  action_item :new, only: :index do
    link_to 'Adquirir Vehiculo', new_acquisition_path
  end


  controller do
    def repair
      @repair = Repair.new(
        employee: current_employee, reason: repair_params[:reason],
        workshop: repair_params[:workshop], quote: repair_params[:quote],
        car: resource
      )

      respond_to do |format|
        if @repair.save
          resource.send_for_repairs!
          format.html { redirect_to admin_car_path(resource), notice: 'Reparacion agregada al vehiculo' }
        else
          format.html { render :showrepair, alert: @repair.errors }
        end
      end


    end

    def end_repair
      respond_to do |format|
        resource.end_repairs!
        format.html { redirect_to admin_car_path(resource), notice: 'Reparacion finalizada.' }
      end
    end

    def publish
      respond_to do |format|
        if resource.publish!
          format.html { redirect_to admin_car_path(resource), notice: 'El Vehiculo se ha puesto a la venta' }
        else
          format.html { redirect_to admin_car_path(resource), error: 'El Vehiculo no se puede poner a la venta. Verifique que los campos nesesarios estan llenos.' }
        end
      end
    end

    def repair_params
      params.require(:repair).permit(:workshop, :reason, :quote)
    end
  end
end
