class Dashboard::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all.order('updated_at DESC').page(params[:page])
    # raise @users.inspect
  end
end
