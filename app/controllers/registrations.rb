class RegistrationsController < Devise::RegistrationsController
  def new
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    # redirect_to root_path
  end

  def create
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    # redirect_to root_path
  end
end
