class QuestionaryController < ApplicationController
  before_action :authenticate_user!
  layout "fondesoapp"

  def index
    if current_user.questionary.present?
      redirect_to profiles_path
    end
  end
end
