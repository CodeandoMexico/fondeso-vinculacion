class QuestionaryController < ApplicationController
  before_action :authenticate_user!
  layout "fondesoapp"

  def index
  end
end
