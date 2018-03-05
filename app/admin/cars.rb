ActiveAdmin.register Car do
  permit_params :brand_id, :model, :license_plate, :year, :color, :milage, :maintenances, :fuel_id,
                :transmission_id, :reservation_price, :state,:sell_price, :buy_price, :technical_review_expiration, :book, :publication, :cc, :permit, :soap, :appraisal, :property, :branch_id, repair: %i[workshop reason quote]
  scope 'Todos', :all, default: true
  scope 'En Reparaciones', :in_repairs
  scope 'Disponibles', :available

  index do
    selectable_column
    column :brand
    column :model
    column :license_plate
    column :year
    column :color do |car|
      link_to(car.color, '#',
              html_options = { class: 'btn',
                               style: "background-color: #{car.color}; color: #{car.color};" })
    end
    column :milage do |car|
      "#{number_with_precision(car.milage, precision: 1, delimiter: ',')} KM"
    end
    column :maintenances
    column :fuel
    column :transmission
    column :buy_price do |car|
      number_to_currency(car.buy_price)
    end
    column :status
    column :branch
    actions
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
      row :status
      row :branch
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
  end

  filter :brand
  filter :model
  filter :year

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
      f.input :sell_price
      f.input :buy_price
      f.input :technical_review_expiration, as: :datepicker
      f.input :book
      f.input :publication
      f.input :cc
      f.input :permit
      f.input :soap
      f.input :appraisal
      f.input :property
      f.input :branch
    end
    f.actions
  end

  member_action :showrepair, method: :get do
    @page_title = 'Enviar a taller'
    @repair ||= Repair.new
  end
  member_action :repair, method: :post

  action_item :repair, only: :show, if: proc { resource.state == 1 } do
    link_to 'Enviar a taller', showrepair_admin_car_path(car)
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
          resource.update(state: 2)
          format.html { redirect_to admin_car_path(resource), notice: 'Reparacion agregada al vehiculo' }
        else
          format.html { render :showrepair, alert: @repair.errors }
        end
      end
    end

    def repair_params
      params.require(:repair).permit(:workshop, :reason, :quote)
    end
  end
end
