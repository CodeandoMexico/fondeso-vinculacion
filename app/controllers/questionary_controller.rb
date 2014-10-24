class QuestionaryController < ApplicationController
  before_action :authenticate_user!
  layout "fondesoapp"

  def index
    if current_user.has_answered_a_questionary?
      redirect_to profiles_path
    end
  end

  def save
    current_user.answers = params[:answers]
    current_user.save

    render nothing: true
  end
end
