class Admins::RegistrationsController < Devise::RegistrationsController
  protected
    def after_sign_up_path_for(resource)
      funds_path
    end
end
