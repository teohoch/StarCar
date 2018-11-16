class ActiveAdmin::Devise::SessionsController
  def after_sign_in_path_for(resource)
    if resource.has_role? :administrator
      admin_dashboard_path
    else
      '/'
    end
  end

  def after_sign_out_path_for(resource)
    '/'
  end
end