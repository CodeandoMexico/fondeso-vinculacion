class Users::SessionsController < Devise::SessionsController
  def show_current_user
    render json: current_user
  end

  protected
    def after_sign_in_path_for(resource)
      root_path
    end

    def after_sign_out_path_for(resource)
      root_path
    end
end
