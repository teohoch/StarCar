ActiveAdmin.register Financier do
  menu priority: 3
  permit_params :name

  form do |f|
    f.inputs do

      f.input :name
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
    end
  end

  index do
    selectable_column
    column :name
    actions
  end


end
