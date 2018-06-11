ActiveAdmin.register FinancierPayment do
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
  actions :index, :show

  config.xls_builder.i18n_scope = [:attributes]

  index do
    column :amount do |payment|
      number_to_currency(payment.amount)
    end
    column :sale
    column :status
    column :financier
    column :down_payment do |payment|
      number_to_currency(payment.down_payment)
    end
    actions
  end

  show do
    attributes_table do
      row :amount do |payment|
        number_to_currency(payment.amount)
      end
      row :sale
      row :status
      row :financier
      row :down_payment do |payment|
        number_to_currency(payment.down_payment)
      end
    end
  end
end
