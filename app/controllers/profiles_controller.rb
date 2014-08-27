class ProfilesController < ApplicationController
  def handshake
    # establish a connection with the server
    render nothing: true
  end

  def show
    render json: Fund.search_with_category(profile_params[:category_name])
  end

  def answers
    answers = Fondeso::Answer.new
    puts '---------------------------------------------- controller logic ----------------------------------------------'
    # we need to save everything to the database
    # parse the data from the questionary
    questionary_answers = params[:answers]
    questionary_filters = params[:filters]
    answers.extract_question_data_from(questionary_answers)
    # let's process the questionary answers
    winning_profile = answers.process_questionary
    puts "lets redirect to #{winning_profile.uri}"
    render json: winning_profile
  end

  private

  def profile_params
    params.permit(:category_name)
  end
end
