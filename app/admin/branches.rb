ActiveAdmin.register Branch do
  permit_params :title, :location, :phone, :manager_id
  menu priority: 4

  form do |f|
    f.inputs do
      f.input :title
      f.input :location
      f.input :phone
      f.input :manager
    end
    f.actions
  end

  show do
    attributes_table do
      row :title
      row :location
      row :phone
      row :manager
    end
  end

  index do
    selectable_column
    column :title
    column :location
    column :phone
    column :manager
    actions
  end


end
