ActiveAdmin.register Cost do
  belongs_to :car
  permit_params :car, :reason, :amount

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :reason
      f.input :amount
    end
    f.actions
  end


end
