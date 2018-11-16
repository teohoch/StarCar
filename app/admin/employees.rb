ActiveAdmin.register Employee do
  permit_params :email, :password, :password_confirmation, :name, :surname,
                :rut, :address, :phone, { avatar: [] }, role_ids: []

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
      row :folio
      row :rut
      row :email
      row :name
      row :surname
      row :address
      row :phone
      row :created_at
      row :roles do |user|
        user.roles.collect { |r| r.name.capitalize }.join(', ')
      end
      row :avatar do |user|
        image_tag user.avatar
      end
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
      f.input :roles, collection: Role.global, as: :check_boxes,
                      label_method: ->(el) { t "simple_form.options.user.roles.#{el.name}" }
      f.input :avatar, as: :file
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  controller do
    def permitted_params
      params.permit(employee: [:username, :email, :password, :password_confirmation, :name, :surname, :rut,
                                       :address, :phone, :avatar, role_ids: []])

    end
  end
end
