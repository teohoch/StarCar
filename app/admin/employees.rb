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

  show do
    attributes_table do
      row :rut
      row :email
      row :name
      row :surname
      row :address
      row :phone
      row :created_at
      row :roles do |user|
        user.roles.collect {|r| r.name.capitalize }.join(", ")
      end
    end
    active_admin_comments
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
      f.input :roles, collection: Role.global, as: :check_boxes,
                      label_method: ->(el) { t "simple_form.options.user.roles.#{el.name}" }
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  controller do
    def update
      params[:employee].each{|k,v| resource.send("#{k}=",v)}
      super
    end

    def permitted_params
      params.permit employee: [:username, :email, :password, :password_confirmation, :name, :surname, :rut, :address, :phone, :role_ids]
    end
  end
end
