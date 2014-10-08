class Admins::RegistrationsController < Devise::RegistrationsController
  def new
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    # redirect_to root_path
  end

  def create
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    # redirect_to root_path
  end

  protected
    def after_sign_up_path_for(resource)
      funds_path
    end
end
