ActiveAdmin.register Client do
  menu priority: 2
  permit_params :email, :name, :surname, :rut, :address, :phone
  decorate_with ClientDecorator

  index do
    selectable_column
    column :email
    column :name
    column :surname
    column :rut
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :rut
      row :email
      row :name
      row :surname
      row :address
      row :phone
    end
    active_admin_comments
  end

  filter :rut
  filter :email
  filter :name
  filter :surname

  form do |f|
    f.inputs do
      f.input :email
      f.input :name
      f.input :surname
      f.input :rut
      f.input :address
      f.input :phone

    end
    f.actions
  end


end
