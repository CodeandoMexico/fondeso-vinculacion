class Users::RegistrationsController < Devise::RegistrationsController
  protected
    def after_sign_up_path_for(resource)
      new_user_session_path
    end

    # def after_update_path_for(resource)
    #   redirect_to new_user_registration_path
    # end
end
