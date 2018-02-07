ActiveAdmin.register Employee do
  permit_params :email, :password, :password_confirmation, :name, :surname, :rut, :address, :phone

  index do
    selectable_column
    column :email
    column :name
    column :surname
    column :rut
    column :created_at
    actions
  end

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
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
