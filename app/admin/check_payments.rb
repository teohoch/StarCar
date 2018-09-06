ActiveAdmin.register CheckPayment do
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
 decorate_with CheckPaymentDecorator
 actions :index, :show
 index do
   column :folio
   column :number
   column :date
   column :bank
   column :amount
   actions
 end

end
