class ProfilesController < ApplicationController
  def handshake
    # establish a connection with the server
    render nothing: true
  end

  def show
    puts '---------------------------------------------- funds & filters ----------------------------------------------'
    render json: Fund.search_with_category(category_params[:category_name])
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
    render json: { profile: winning_profile, filters: questionary_filters }
  end

  private

  def category_params
    params.permit(:category_name)
  end

  def filter_params
    params.require(:filters).permit(
      :MUJ,
      :RUR,
      :JOV,
      :TER,
      :ART,
      :TAB,
      :BAC,
      :EXP,
      :MAN,
      :PIN,
      :CON,
      :TUR,
      :ATI,
      :IND,
      :TIC
    )
  end
end
