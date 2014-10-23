class QuestionaryController < ApplicationController
  before_action :authenticate_user!
  layout "fondesoapp"

  def index
    if current_user.questionary.present?
      redirect_to profiles_path
    end
  end

  def save
    current_user.questionary = params[:answers]
    current_user.save
    
    render nothing: true
  end
end
