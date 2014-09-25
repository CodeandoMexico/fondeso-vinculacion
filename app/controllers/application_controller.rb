class ApplicationController < ActionController::Base
  respond_to :html, :json

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery
  #
  # after_filter :set_csrf_cookie_for_ng
  #
  # def set_csrf_cookie_for_ng
  #   cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  # end
  #
  # protected
  #   def verified_request?
  #     super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
  #   end
  protect_from_forgery

  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers, :set_csrf_cookie_for_ng
  before_action :configure_permitted_parameters, if: :devise_controller?

    # For all responses in this controller, return the CORS access control headers.

    def cors_set_access_control_headers
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
      headers['Access-Control-Request-Method'] = '*'
      headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
      headers['Access-Control-Allow-Credentials'] = true
      headers['Access-Control-Max-Age'] = "1728000"
    end

    # If this is a preflight OPTIONS request, then short-circuit the
    # request, return only the necessary headers and return an empty
    # text/plain.

    def cors_preflight_check
      if request.method == :options
        headers['Access-Control-Allow-Origin'] = '*'
        headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
        headers['Access-Control-Request-Method'] = '*'
        headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
        headers['Access-Control-Allow-Credentials'] = true
        headers['Access-Control-Max-Age'] = '1728000'
        render :text => '', :content_type => 'text/plain'
      end
    end

    def set_csrf_cookie_for_ng
      cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
    end

  protected

    def verified_request?
      super || form_authenticity_token == request.headers['X_XSRF_TOKEN']
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << :name
    end
end
