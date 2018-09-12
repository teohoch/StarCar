ActiveAdmin.register Sale do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  #
  decorate_with SaleDecorator
  actions :index, :show

  config.xls_builder.delete_columns :id, :created_at, :updated_at
  index do
    selectable_column
    column :folio
    column :branch
    column :employee
    column :car
    column :client
    column :final_price
    actions
  end
end
