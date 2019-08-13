ActiveAdmin.register FinancierPayment do
  menu priority: 9
  actions :index, :show, :edit, :update, :collect
  permit_params :financier_id, :amount, :financier_payable_type, :financier_payable_id, :status

  config.xls_builder.i18n_scope = [:attributes]

  index do
    column :amount do |payment|
      number_to_currency(payment.amount)
    end
    column :created_at
    column :financier_payable_type do |payment|
      link_to(I18n.t("activerecord.models.#{payment.financier_payable_type.downcase}.one"),
              send("#{payment.financier_payable_type.downcase}_path", payment.financier_payable_id))
    end
    column :state
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
      row :financier_payable_type do |payment|
        link_to(I18n.t("activerecord.models.#{payment.financier_payable_type.downcase}.one"),
                       send("#{payment.financier_payable_type.downcase}_path", payment.financier_payable_id))
      end
      row :state
      row :financier
      row :down_payment do |payment|
        number_to_currency(payment.down_payment)
      end
      row :participation
    end
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :financier
      f.input :amount
      f.input :down_payment
    end
    f.actions
  end

  member_action :collect, method: :get

  action_item :collect, only: :show, if: proc { resource.may_collect? } do
    link_to 'Cobrar', collect_admin_financier_payment_path(resource)
  end

  controller do
    def scoped_collection
      FinancierPayment.in_favour
    end

    def collect
      respond_to do |format|
        resource.collect!
        format.html { redirect_to admin_financier_payment_path(resource), notice: 'Pago de financiera cobrado.' }
      end
    end
  end
end
