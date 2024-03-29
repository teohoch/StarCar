class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.root_url, :flash => { :error => exception.message} }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

  def flash_message(type, text)
    flash[type] ||= []
    flash[type] << text
  end

  def current_ability
    @current_ability ||= Ability.new(current_employee)
  end

end
