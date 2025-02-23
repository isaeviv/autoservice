class ApplicationController < ActionController::Base
  include Pagy::Backend
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  # helper_method :current_workspace
  

  before_action :set_locale
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :surname, :email, :password ])
  end

  def set_locale
    I18n.locale = :ru
  end
  
  def simple_link_to(title, path, params={})
    link_to title, path, ** params, data: { turbo: false }
  end

  # def current_workspace
 #    @workspace ||= Workspace.find_by(id: params[:id])
 #  end
end
