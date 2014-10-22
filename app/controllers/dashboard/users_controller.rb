class Dashboard::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    respond_to do |format|
      format.html {
        @users = User.all.order('updated_at DESC').page(params[:page])
      }
      format.csv { send_data User.to_csv }
    end
  end
end
