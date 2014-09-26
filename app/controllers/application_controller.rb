class ApplicationController < ActionController::Base
  # protect_from_forgery
  protect_from_forgery with: :exception
  layout :layout_by_resource
  respond_to :html, :json
  before_action :configure_permitted_parameters, if: :devise_controller?


  # before_filter :cors_preflight_check
  # after_filter :cors_set_access_control_headers, :set_csrf_cookie_for_ng

    # For all responses in this controller, return the CORS access control headers.

    # def cors_set_access_control_headers
    #   headers['Access-Control-Allow-Origin'] = 'http://fondeso-frontend-staging.herokuapp.com'
    #   headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    #   headers['Access-Control-Request-Method'] = '*'
    #   headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    #   headers['Access-Control-Allow-Credentials'] = 'true'
    #   headers['Access-Control-Max-Age'] = "1728000"
    # end
    #
    # # If this is a preflight OPTIONS request, then short-circuit the
    # # request, return only the necessary headers and return an empty
    # # text/plain.
    #
    # def cors_preflight_check
    #   if request.method == :options
    #     headers['Access-Control-Allow-Origin'] = 'http://fondeso-frontend-staging.herokuapp.com'
    #     headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    #     headers['Access-Control-Request-Method'] = '*'
    #     headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    #     headers['Access-Control-Allow-Credentials'] = 'true'
    #     headers['Access-Control-Max-Age'] = '1728000'
    #     render :text => '', :content_type => 'text/plain'
    #   end
    # end
    #
    # def set_csrf_cookie_for_ng
    #   cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
    # end

  protected

    # def verified_request?
    #   super || form_authenticity_token == request.headers['X_XSRF_TOKEN']
    # end

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
