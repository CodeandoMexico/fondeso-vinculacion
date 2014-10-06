class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout :layout_by_resource
  respond_to :html, :json
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << :name
    end

    def layout_by_resource
      if devise_controller? && resource_name == :user
        "fondesosession"
      else
        "application"
      end
    end
end
