class Admins::SessionsController < Devise::SessionsController
  protected
    def after_sign_in_path_for(resource)
      funds_path
    end

    def after_sign_out_path_for(resource)
      root_path
    end
end
