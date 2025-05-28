class ApplicationController < ActionController::Base
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  include Pundit::Authorization
  include Pagy::Backend
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :set_locale
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :current_workspace

  def current_workspace
    @current_workspace ||= Workspace.find_by(id: session[:current_workspace_id])
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :surname, :email, :password ])
  end

  def set_locale
    I18n.locale = :ru
  end

  def simple_link_to(title, path, params = {})
    link_to title, path, ** params, data: { turbo: false }
  end

  private
  def user_not_authorized(exception)
   policy_name = exception.policy.class.to_s.underscore
   flash[:alert] = t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default
   redirect_back_or_to(root_path)
  end
end
