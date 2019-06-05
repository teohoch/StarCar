ActiveAdmin.register CheckPayment do
  menu priority: 8
  decorate_with CheckPaymentDecorator
  actions :index, :show, :edit, :update, :collect

  permit_params :amount, :check_payable_type, :check_payable_id, :status, :code, :number, :bank, :due_date, :date

  scope 'Todos', :all
  scope 'Recibidos', :in_favour
  scope 'A Pagar', :to_pay

  index do
    column :concesionary do |payment|
      if payment.check_payable_type == Acquisition.name
        payment.check_payable.car_provider.name
      else
        'N/A'
      end
    end
    column :state
    column :check_payable_type do |payment|
      link_to(I18n.t("activerecord.models.#{payment.check_payable_type.downcase}.one"),
              send("#{payment.check_payable_type.downcase}_path", payment.check_payable_id))
    end
    column :bank
    column :amount
    actions
  end

  show do
    attributes_table do
      row :folio
      row :amount
      row :check_payable_type do |payment|
        link_to(I18n.t("activerecord.models.#{payment.check_payable_type.downcase}.one"),
                send("#{payment.check_payable_type.downcase}_path", payment.check_payable_id))
      end
      row :state
      row :code
      row :bank
      row :due_date
      if check_payment.check_payable_type != Acquisition.name
        row :date
      end



    end
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :amount
      f.input :code
      f.input :number
      f.input :bank
      f.input :due_date
    end
    f.actions
  end

  member_action :collect, method: :get

  action_item :collect, only: :show, if: proc { resource.may_collect? } do
    link_to 'Cobrar', collect_admin_check_payment_path(resource)
  end

  controller do

    def collect
      respond_to do |format|
        resource.collect!
        resource.date = DateTime.now
        resource.save!
        format.html { redirect_to admin_check_payment_path(resource), notice: 'Cheque Cobrado.' }
      end
    end
  end
end
